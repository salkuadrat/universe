import 'package:curved_animation_controller/curved_animation_controller.dart';
import 'package:flutter/material.dart';

import '../../core/geometry/point.dart';
import '../../map/map.dart';
import '../layer.dart';

class LocationIndicator extends MapLayer {
  final double radius;
  final double overlayRadius;
  final double ringRadius;
  final Color color;
  final bool animate;

  const LocationIndicator({
    Key? key,
    this.radius = 10,
    this.overlayRadius = 100,
    this.ringRadius = 3,
    this.color = Colors.lightBlue,
    this.animate = true,
  }) : super(key: key);

  @override
  Widget buildLayer(BuildContext context, MapState map) {
    if (map.location == null) {
      return Container();
    }

    double scale = map.getZoomScale(map.zoom, map.zoom);
    UPoint locationPoint = map.project(map.position) * scale - map.pixelOrigin;
    Offset location = map.pointToOffset(locationPoint);

    return AnimatedIndicator(
      location: location,
      overlayRadius: map.options.live ? overlayRadius : 0,
      ringRadius: ringRadius,
      radius: radius,
      color: color,
      animate: animate && map.isLocating,
    );
  }
}

class AnimatedIndicator extends StatefulWidget {
  final Offset? location;
  final double? radius;
  final double? overlayRadius;
  final double? ringRadius;
  final Color? color;
  final bool animate;

  double get insideRadius => radius! - ringRadius!;

  const AnimatedIndicator({
    Key? key,
    this.location,
    this.radius,
    this.overlayRadius,
    this.ringRadius,
    this.color,
    this.animate = true,
  }) : super(key: key);

  @override
  AnimatedIndicatorState createState() => AnimatedIndicatorState();
}

class AnimatedIndicatorState extends State<AnimatedIndicator>
    with SingleTickerProviderStateMixin {
  CurvedAnimationController? _animation;

  @override
  void initState() {
    super.initState();

    if (widget.animate) {
      _animation = CurvedAnimationController(
        begin: widget.insideRadius,
        end: widget.insideRadius - 1,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        vsync: this,
      );

      _animation?.addListener(() => setState(() {}));
      _animation?.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _animation?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints c) {
      Size size = Size(c.maxWidth, c.maxHeight);
      return Stack(
        children: [
          CustomPaint(
            painter: OuterIndicatorPainter(
              location: widget.location,
              radius: widget.overlayRadius,
              color: widget.color,
              opacity: 0.1,
            ),
            size: size,
          ),
          CustomPaint(
            painter: IndicatorPainter(
              radius: widget.radius,
              insideRadius: widget.animate && _animation != null
                  ? _animation!.value
                  : widget.insideRadius,
              location: widget.location,
              color: widget.color,
            ),
            size: size,
          ),
        ],
      );
    });
  }
}

class IndicatorPainter extends CustomPainter {
  final Offset? location;
  final double? radius;
  final double? insideRadius;
  final Color? color;

  IndicatorPainter({
    this.location,
    this.radius,
    this.insideRadius,
    this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    canvas.drawCircle(location!, radius!, paint);

    final insidePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color!;

    canvas.drawCircle(location!, insideRadius!, insidePaint);
  }

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) => false;
}

class OuterIndicatorPainter extends CustomPainter {
  final Offset? location;
  final double? radius;
  final Color? color;
  final double? opacity;

  OuterIndicatorPainter({
    this.location,
    this.radius,
    this.color,
    this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // bound the canvas
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    final outerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color!.withOpacity(opacity!);

    canvas.drawCircle(location!, radius!, outerPaint);
  }

  @override
  bool shouldRepaint(OuterIndicatorPainter oldDelegate) => false;
}

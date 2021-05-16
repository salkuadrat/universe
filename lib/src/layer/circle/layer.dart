import 'package:flutter/material.dart';

import '../../core/latlng/distance/distance.dart';
import '../../core/latlng/latlng.dart';
import '../../map/map.dart';
import '../layer.dart';

class CircleLayer extends ShapeLayer {
  final Circle? circle;
  final List<Circle> circles;
  final CircleLayerOptions? options;

  bool get hasCircle => circle != null;
  bool get hasCircles => circles.isNotEmpty;

  // can accept a single circle or list of circles
  const CircleLayer(dynamic circle, {Key? key, this.options})
      : assert(
            circle is Circle || (circle is List<Circle> && circle.length > 0)),
        this.circle = circle is Circle ? circle : null,
        this.circles = circle is List<Circle> ? circle : const <Circle>[],
        super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapStates map) {
    if (hasCircles) return _circles(context, map);
    if (hasCircle) return _circle(context, map, circle!);
    return Container();
  }

  Widget _circles(BuildContext context, MapStates map) => Stack(
        children: [
          for (Circle circle in circles) _circle(context, map, circle),
        ],
      );

  Widget _circle(BuildContext context, MapStates map, Circle circle) {
    final scale = map.getZoomScale(map.zoom, map.zoom);
    final centerPoint = map.project(circle.latlng) * scale - map.pixelOrigin;

    double? radius = circle.radius;

    if (circle.isRadiusInMeter) {
      final d = Distance();
      final r = d.offset(circle.latlng, circle.radius, 180);
      final radiusPoint = map.project(r) * scale - map.pixelOrigin;
      radius = radiusPoint.y - centerPoint.y;
    }

    final primaryColor = Theme.of(context).primaryColor;
    final strokeWidth = circle.strokeWidth ?? options!.strokeWidth;
    final canvasSize = 2 * (radius! + strokeWidth);
    final left = centerPoint.x - (radius + strokeWidth);
    final top = centerPoint.y - (radius + strokeWidth);
    final center = radius + strokeWidth;
    final canvasCenter = Offset(center, center);

    return Positioned(
      top: top,
      left: left,
      child: InteractiveGestureDetector(
        position: circle.latlng,
        data: circle.data,
        options: options,
        child: CustomPaint(
          painter: CirclePainter(
            center: canvasCenter,
            radius: radius,
            stroke: circle.stroke ?? options!.stroke,
            strokeColor: circle.strokeColor ??
                options!.strokeColor ??
                circle.fillColor ??
                options!.fillColor ??
                primaryColor,
            strokeOpacity: circle.strokeOpacity ?? options!.strokeOpacity,
            strokeWidth: circle.strokeWidth ?? options!.strokeWidth,
            strokeCap: circle.strokeCap ?? options!.strokeCap,
            strokeJoin: circle.strokeJoin ?? options!.strokeJoin,
            fill: circle.fill ?? options!.fill,
            fillColor: circle.fillColor ?? options!.fillColor ?? primaryColor,
            fillOpacity: circle.fillOpacity ?? options!.fillOpacity,
          ),
          child: Container(
            width: canvasSize,
            height: canvasSize,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

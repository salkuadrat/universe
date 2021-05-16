import 'package:flutter/widgets.dart';

class CirclePainter extends CustomPainter {
  final Offset? center;
  final double? radius;
  final bool? stroke;
  final Color? strokeColor;
  final double? strokeOpacity;
  final double? strokeWidth;
  final StrokeCap? strokeCap;
  final StrokeJoin? strokeJoin;
  final bool? fill;
  final Color? fillColor;
  final double? fillOpacity;

  CirclePainter({
    this.center,
    this.radius = 0.0,
    this.stroke,
    this.strokeColor,
    this.strokeOpacity,
    this.strokeWidth,
    this.strokeCap,
    this.strokeJoin,
    this.fill,
    this.fillColor,
    this.fillOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    // always check for strokeWidth and strokeColor before painting the stroke
    final isPaintStroke =
        stroke! && (strokeWidth! > 0) && (strokeColor != null);
    final isPaintFill = fill! && (fillColor != null);

    if (isPaintStroke) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..color = strokeColor!.withOpacity(strokeOpacity!)
        ..strokeCap = strokeCap!
        ..strokeJoin = strokeJoin!
        ..strokeWidth = strokeWidth!;

      canvas.drawCircle(center!, radius!, paint);
    }

    if (isPaintFill) {
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = fillColor!.withOpacity(fillOpacity!);

      canvas.drawCircle(center!, radius!, paint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldCircle) => false;
}

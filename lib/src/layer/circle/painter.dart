import 'package:flutter/widgets.dart';

import 'circle.dart';

class CirclePainter extends CustomPainter {
  
  final Circle circle;
  final Offset center;
  final double radius;
  final CircleLayerOptions options;

  CirclePainter(this.circle, this.center, {this.radius=0.0, this.options});

  @override
  void paint(Canvas canvas, Size size) {
    // bound the canvas
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    final fillColor = circle.fillColor ?? options.fillColor;
    final fillOpacity = circle.fillOpacity ?? options.fillOpacity;
    final applyFillColor = fillColor?.withOpacity(fillOpacity ?? 1.0);
    final paintFill = ((circle.fill is bool && circle.fill) || options.fill) && applyFillColor != null;

    if (paintFill) {
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = applyFillColor;

      canvas.drawCircle(center, radius, paint);
    }

    final strokeColor = circle.strokeColor ?? options.strokeColor;
    final strokeOpacity = circle.strokeOpacity ?? options.strokeOpacity;
    final strokeWidth = circle.strokeWidth ?? options.strokeWidth;
    final applyStrokeColor = strokeColor?.withOpacity(strokeOpacity ?? 1.0);

    // always check for strokeWidth and strokeColor
    // before painting the stroke
    final hasStroke = (strokeWidth > 0) && (applyStrokeColor != null);
    final paintStroke = ((circle.stroke is bool && circle.stroke) || options.stroke) && hasStroke;

    if(paintStroke) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth?.toDouble()
        ..strokeCap = circle.strokeCap ?? options.strokeCap
        ..strokeJoin = circle.strokeJoin ?? options.strokeJoin
        ..color = applyStrokeColor;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldCircle) => false;
}
import 'package:flutter/widgets.dart';

import 'marker.dart';
import 'options.dart';

class CirclePainter extends CustomPainter {
  
  final Circle circle;
  final CircleLayerOptions options;

  CirclePainter(this.circle, {this.options});

  @override
  void paint(Canvas canvas, Size size) {
    // bound the canvas
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    final fillColor = circle.fillColor ?? options.fillColor;
    final fillOpacity = circle.fillOpacity ?? options.fillOpacity;
    final applyFillColor = fillColor?.withOpacity(fillOpacity ?? 1.0);
    final paintFill = (circle.fill || options.fill) && applyFillColor != null;

    if (paintFill) {
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = applyFillColor;

      canvas.drawCircle(circle.center, circle.radius, paint);
    }

    final strokeColor = circle.color ?? options.color;
    final strokeOpacity = circle.opacity ?? options.opacity;
    final strokeWidth = circle.weight ?? options.weight;
    final applyStrokeColor = strokeColor?.withOpacity(strokeOpacity ?? 1.0);

    // always check for strokeWidth and strokeColor
    // before painting the stroke
    final hasStroke = strokeWidth > 0 && applyStrokeColor != null;
    final paintStroke = (circle.stroke || options.stroke) && hasStroke;

    if(paintStroke) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth?.toDouble()
        ..strokeCap = circle.strokeCap ?? options.strokeCap
        ..strokeJoin = circle.strokeJoin ?? options.strokeJoin
        ..color = applyStrokeColor;

      canvas.drawCircle(circle.center, circle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldCircle) => false;
}
import 'package:flutter/widgets.dart';

import 'marker.dart';
import 'options.dart';

class CirclePainter extends CustomPainter {
  
  final Circle circle;
  final CircleLayerOptions options;

  CirclePainter(this.circle, {this.options});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    if (circle.fill) {
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = circle.fillColor?.withOpacity(circle.fillOpacity ?? 1.0);

      canvas.drawCircle(circle.center, circle.radius, paint);
    }
    

    if(circle.stroke && circle.weight > 0.0) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = circle.weight
        ..color = circle.color?.withOpacity(circle.opacity ?? 1.0);

      canvas.drawCircle(circle.center, circle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldCircle) => false;
}
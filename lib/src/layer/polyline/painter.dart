import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/rendering.dart';

import 'polyline.dart';

class PolylinePainter extends CustomPainter {

  final Polyline polyline;
  final List<Offset> points;
  final PolylineLayerOptions options;

  PolylinePainter(this.polyline, this.points, {this.options});

  bool get hasPoints => points != null && points.isNotEmpty;
  bool get noPoints => !hasPoints;

  get gradientColors => polyline.gradientStrokeColors ?? options.gradientStrokeColors;
  get gradientStops => polyline.gradientStrokeStops ?? options.gradientStrokeStops;

  bool get hasGradient => gradientColors != null && gradientColors.isNotEmpty;
  bool get hasGradientStops => 
    gradientStops != null && 
    gradientStops.length == gradientColors.length;
  
  @override
  void paint(Canvas canvas, Size size) {
    if(noPoints) {
      return;
    }

    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    final strokeColor = polyline.strokeColor ?? options.strokeColor;
    final strokeWidth = polyline.strokeWidth ?? options.strokeWidth;
    final strokeOpacity = polyline.strokeOpacity ?? options.strokeOpacity;
    final radius = strokeWidth / 2;
    final spacing = strokeWidth * 1.5;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = polyline.strokeCap ?? options.strokeCap
      ..strokeJoin = polyline.strokeJoin ?? options.strokeJoin
      ..blendMode = BlendMode.srcOver;
    
    hasGradient 
      ? paint.shader = _gradient() 
      : paint.color = strokeColor?.withOpacity(strokeOpacity ?? 1.0);

    // TODO research more about filter and border, why use them?

    canvas.saveLayer(rect, Paint());

    if(polyline.isDotted) {
      paint.style = PaintingStyle.fill;
      _paintDottedLine(canvas, radius, spacing, paint);
    } else {
      _paintLine(canvas, paint);
    }

    canvas.restore();
  }

  ui.Gradient _gradient() => ui.Gradient.linear(
    points.first, 
    points.last, 
    gradientColors,
    _stops(),
  );

  List<double> _stops() {
    if(hasGradientStops) {
      return gradientStops;
    }

    final stopInterval = 1.0 / gradientColors.length;
    return gradientColors.map(
      (color) => gradientColors.indexOf(color) * stopInterval).toList();
  }

  void _paintLine(Canvas canvas, Paint paint) {
    final start = points.first;
    final path = Path();
    
    path.moveTo(start.dx, start.dy);
    points.removeAt(0);

    for(Offset point in points) {
      path.lineTo(point.dx, point.dy);
    }

    canvas.drawPath(path, paint);
  }

  void _paintDottedLine(Canvas canvas, double radius, double stepLength, Paint paint) {
    
    num startDistance = 0.0;
    final path = Path();

    for (var i = 0; i < points.length - 1; i++) {
      var current = points[i];
      var next = points[i + 1];
      var totalDistance = _distance(current, next);
      var distance = startDistance;

      while (distance < totalDistance) {
        var f1 = distance / totalDistance;
        var f0 = 1.0 - f1;

        var offset = Offset(
          current.dx * f0 + next.dx * f1, 
          current.dy * f0 + next.dy * f1,
        );

        path.addOval(Rect.fromCircle(center: offset, radius: radius));
        distance += stepLength;
      }

      startDistance = distance < totalDistance
        ? stepLength - (totalDistance - distance)
        : distance - totalDistance;
    }

    path.addOval(Rect.fromCircle(center: points.last, radius: radius));
    canvas.drawPath(path, paint);
  }

  // pure trigonometry to calculate distance between a and b
  double _distance(Offset a, Offset b) {
    final dx = a.dx - b.dx;
    final dy = a.dy - b.dy;
    return math.sqrt(dx * dx + dy * dy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
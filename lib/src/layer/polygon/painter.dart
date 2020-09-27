import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/rendering.dart';

import 'polygon.dart';

class PolygonPainter extends CustomPainter {

  final Polygon polygon;
  final List<Offset> points;
  final List<List<Offset>> holePointsList;
  final PolygonLayerOptions options;

  PolygonPainter(this.polygon, this.points, this.holePointsList, {this.options});

  bool get hasPoints => points != null && points.isNotEmpty;
  bool get noPoints => !hasPoints;

  get gradientFillColors => polygon.gradientFillColors ?? options.gradientFillColors;
  get gradientFillStops => polygon.gradientFillStops ?? options.gradientFillStops;

  bool get hasGradientFill => 
    gradientFillColors != null && gradientFillColors.isNotEmpty;

  bool get hasGradientFillStops => 
    gradientFillStops != null && 
    gradientFillStops.length == gradientFillStops.length;

  get gradientStrokeColors => polygon.gradientStrokeColors ?? options.gradientStrokeColors;
  get gradientStrokeStops => polygon.gradientStrokeStops ?? options.gradientStrokeStops;

  bool get hasGradientStroke => 
    gradientStrokeColors != null && gradientStrokeColors.isNotEmpty;

  bool get hasGradientStrokeStops => 
    gradientStrokeStops != null && 
    gradientStrokeStops.length == gradientStrokeColors.length;

  @override
  void paint(Canvas canvas, Size size) {
    if(noPoints) {
      return;
    }

    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    final fillColor = polygon.fillColor ?? options.fillColor;
    final fillOpacity = polygon.fillOpacity ?? options.fillOpacity;

    final paint = Paint()
      ..style = PaintingStyle.fill;
    
    hasGradientFill 
      ? paint.shader = _gradientFill() 
      : paint.color = fillColor?.withOpacity(fillOpacity ?? 1.0);

    if(holePointsList != null) {
      canvas.saveLayer(rect, paint);

      for(final hpoints in holePointsList) {
        final path = Path();
        path.addPolygon(hpoints, true);
        canvas.drawPath(path, paint);
      }

      paint.blendMode = BlendMode.srcOut;

      final path = Path();
      path.addPolygon(points, true);
      canvas.drawPath(path, paint);
      _paintStroke(canvas);

      canvas.restore();
    } else {
      final path = Path();
      path.addPolygon(points, true);
      canvas.drawPath(path, paint);
      _paintStroke(canvas);
    }
  }

  void _paintStroke(Canvas canvas) {

    final strokeColor = polygon.strokeColor ?? options.strokeColor;
    final strokeWidth = polygon.strokeWidth ?? options.strokeWidth;
    final strokeOpacity = polygon.strokeOpacity ?? options.strokeOpacity;
    final radius = strokeWidth / 2;
    final spacing = strokeWidth * 1.5;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = polygon.strokeCap ?? options.strokeCap
      ..strokeJoin = polygon.strokeJoin ?? options.strokeJoin
      ..blendMode = BlendMode.srcOver;

    hasGradientStroke 
      ? paint.shader = _gradientStroke() 
      : paint.color = strokeColor?.withOpacity(strokeOpacity ?? 1.0);

    // TODO research more about filter and border, why use them?

    if(polygon.isDotted) {
      paint.style = PaintingStyle.fill;
      _paintDottedLine(canvas, points, radius, spacing, paint);
    } else {
      _paintLine(canvas, points, paint);
    }
  }

  void _paintLine(Canvas canvas, List<Offset> offsets, Paint paint) {
    if(offsets != null && offsets.isNotEmpty) {
      final start = offsets.first;
      final path = Path();
      
      path.moveTo(start.dx, start.dy);
      offsets.removeAt(0);

      for(Offset offset in offsets) {
        path.lineTo(offset.dx, offset.dy);
      }

      path.close();
      canvas.drawPath(path, paint);
    }
  }

  void _paintDottedLine(
    Canvas canvas, List<Offset> offsets, 
    double radius, double stepLength, Paint paint) {

    offsets.add(offsets.first);
    num startDistance = 0.0;

    final path = Path();

    for (var i = 0; i < offsets.length - 1; i++) {
      var current = offsets[i];
      var next = offsets[i + 1];
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

    path.addOval(Rect.fromCircle(center: offsets.last, radius: radius));
    canvas.drawPath(path, paint);
  }

  // pure trigonometry to calculate distance between a and b
  double _distance(Offset a, Offset b) {
    final dx = a.dx - b.dx;
    final dy = a.dy - b.dy;
    return math.sqrt(dx * dx + dy * dy);
  }

  ui.Gradient _gradientFill() => ui.Gradient.linear(
    points.first, 
    points.last, 
    gradientFillColors,
    _stopsFill(),
  );

  List<double> _stopsFill() {
    if(hasGradientFillStops) {
      return gradientFillStops;
    }

    final stopInterval = 1.0 / gradientFillColors.length;
    return gradientFillColors.map(
      (color) => gradientFillColors.indexOf(color) * stopInterval).toList();
  }

  ui.Gradient _gradientStroke() => ui.Gradient.linear(
    points.first, 
    points.last, 
    gradientStrokeColors,
    _stopsStroke(),
  );

  List<double> _stopsStroke() {
    if(hasGradientStrokeStops) {
      return gradientStrokeStops;
    }

    final stopInterval = 1.0 / gradientStrokeColors.length;
    return gradientStrokeColors.map(
      (color) => gradientStrokeColors.indexOf(color) * stopInterval).toList();
  }

  @override
  bool shouldRepaint(PolygonPainter oldPainter) => false;
  
}
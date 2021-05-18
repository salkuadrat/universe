import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PolygonPainter extends CustomPainter {
  final List<Offset>? points;
  final List<List<Offset>>? holesPoints;

  final bool? culling;
  final bool? stroke;
  final bool? isDotted;
  final Color? strokeColor;
  final double? strokeWidth;
  final double? strokeOpacity;
  final StrokeCap? strokeCap;
  final StrokeJoin? strokeJoin;
  final PathFillType? pathFillType;
  final Color? fillColor;
  final double? fillOpacity;
  final List<Color>? gradientStrokeColors;
  final List<double>? gradientStrokeStops;
  final List<Color>? gradientFillColors;
  final List<double>? gradientFillStops;

  PolygonPainter({
    this.points,
    this.holesPoints,
    this.culling,
    this.stroke,
    this.isDotted,
    this.strokeColor,
    this.strokeWidth,
    this.strokeOpacity,
    this.strokeCap,
    this.strokeJoin,
    this.pathFillType,
    this.fillColor,
    this.fillOpacity,
    this.gradientStrokeColors,
    this.gradientStrokeStops,
    this.gradientFillColors,
    this.gradientFillStops,
  });

  bool get hasPoints => points != null && points!.isNotEmpty;
  bool get noPoints => !hasPoints;

  bool get hasGradientFill =>
      gradientFillColors != null && gradientFillColors!.isNotEmpty;

  bool get hasGradientFillStops =>
      gradientFillStops != null &&
      gradientFillStops!.length == gradientFillColors!.length;

  bool get hasGradientStroke =>
      gradientStrokeColors != null && gradientStrokeColors!.isNotEmpty;

  bool get hasGradientStrokeStops =>
      gradientStrokeStops != null &&
      gradientStrokeStops!.length == gradientStrokeColors!.length;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    if (noPoints) {
      return;
    }

    final isPaintStroke =
        stroke! && (strokeWidth! > 0) && (strokeColor != null);
    final isPaintHoles = holesPoints is List && holesPoints!.length > 0;

    final paint = Paint()..style = PaintingStyle.fill;

    hasGradientFill
        ? paint.shader = _gradientFill()
        : paint.color = fillColor!.withOpacity(fillOpacity ?? 1.0);

    if (isPaintHoles) {
      canvas.saveLayer(rect, paint);

      for (final hole in holesPoints!) {
        final path = Path();
        path.addPolygon(hole, true);
        canvas.drawPath(path, paint);
      }

      paint.blendMode = BlendMode.srcOut;

      final path = Path();
      path.addPolygon(points!, true);
      canvas.drawPath(path, paint);

      if (isPaintStroke) {
        _paintStroke(canvas);
      }

      canvas.restore();
    } else {
      final path = Path();
      path.addPolygon(points!, true);
      canvas.drawPath(path, paint);

      if (isPaintStroke) {
        _paintStroke(canvas);
      }
    }
  }

  void _paintStroke(Canvas canvas) {
    final radius = strokeWidth! / 2;
    final spacing = strokeWidth! * 1.5;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = strokeCap!
      ..strokeJoin = strokeJoin!
      ..blendMode = BlendMode.srcOver;

    hasGradientStroke
        ? paint.shader = _gradientStroke()
        : paint.color = strokeColor!.withOpacity(strokeOpacity ?? 1.0);

    if (isDotted!) {
      paint.style = PaintingStyle.fill;
      _paintDottedLine(canvas, points!, radius, spacing, paint);
    } else {
      _paintLine(canvas, points, paint);
    }
  }

  void _paintLine(Canvas canvas, List<Offset>? points, Paint paint) {
    if (points != null && points.isNotEmpty) {
      final path = Path();
      final start = points.first;

      path.moveTo(start.dx, start.dy);

      for (var i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }

      path.close();
      canvas.drawPath(path, paint);
    }
  }

  void _paintDottedLine(Canvas canvas, List<Offset> points, double radius,
      double stepLength, Paint paint) {
    final path = Path();

    double startDistance = 0.0;
    points = [points.first, ...points];

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

  ui.Gradient _gradientFill() => ui.Gradient.linear(
        points!.first,
        points!.last,
        gradientFillColors!,
        _stopsFill(),
      );

  List<double>? _stopsFill() {
    if (hasGradientFillStops) {
      return gradientFillStops;
    }

    final stopInterval = 1.0 / gradientFillColors!.length;
    return gradientFillColors!
        .map((color) => gradientFillColors!.indexOf(color) * stopInterval)
        .toList();
  }

  ui.Gradient _gradientStroke() => ui.Gradient.linear(
        points!.first,
        points!.last,
        gradientStrokeColors!,
        _stopsStroke(),
      );

  List<double>? _stopsStroke() {
    if (hasGradientStrokeStops) {
      return gradientStrokeStops;
    }

    final stopInterval = 1.0 / gradientStrokeColors!.length;
    return gradientStrokeColors!
        .map((c) => gradientStrokeColors!.indexOf(c) * stopInterval)
        .toList();
  }

  @override
  bool shouldRepaint(PolygonPainter oldPainter) => false;
}

import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PolylinePainter extends CustomPainter {
  final List<Offset>? points;
  final Color? strokeColor;
  final double? strokeWidth;
  final double? strokeOpacity;
  final StrokeCap? strokeCap;
  final StrokeJoin? strokeJoin;
  final PathFillType? pathFillType;
  final bool? isDotted;
  final bool? culling;
  final List<Color>? gradientStrokeColors;
  final List<double>? gradientStrokeStops;

  PolylinePainter({
    this.points,
    this.strokeColor,
    this.strokeWidth,
    this.strokeOpacity,
    this.strokeCap,
    this.strokeJoin,
    this.pathFillType,
    this.isDotted,
    this.culling,
    this.gradientStrokeColors,
    this.gradientStrokeStops,
  });

  bool get hasPoints => points != null && points!.isNotEmpty;
  bool get noPoints => !hasPoints;

  bool get hasGradient =>
      gradientStrokeColors != null && gradientStrokeColors!.isNotEmpty;

  bool get hasGradientStops =>
      gradientStrokeStops != null &&
      gradientStrokeStops!.length == gradientStrokeColors!.length;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    if (noPoints) {
      return;
    }

    final radius = strokeWidth! / 2;
    final spacing = strokeWidth! * 1.5;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = strokeCap!
      ..strokeJoin = strokeJoin!
      ..blendMode = BlendMode.srcOver;

    hasGradient
        ? paint.shader = _gradient()
        : paint.color = strokeColor!.withOpacity(strokeOpacity!);

    canvas.saveLayer(rect, paint);

    if (isDotted!) {
      paint.style = PaintingStyle.fill;
      _paintDottedLine(canvas, radius, spacing, paint);
    } else {
      _paintLine(canvas, paint);
    }

    canvas.restore();
  }

  ui.Gradient _gradient() => ui.Gradient.linear(
        points!.first,
        points!.last,
        gradientStrokeColors!,
        _stops(),
      );

  List<double>? _stops() {
    if (hasGradientStops) {
      return gradientStrokeStops;
    }

    final stopInterval = 1.0 / gradientStrokeColors!.length;
    return gradientStrokeColors!
        .map((color) => gradientStrokeColors!.indexOf(color) * stopInterval)
        .toList();
  }

  void _paintLine(Canvas canvas, Paint paint) {
    final start = points!.first;
    final path = Path()..fillType = pathFillType!;

    path.moveTo(start.dx, start.dy);

    for (var i = 1; i < points!.length; i++) {
      path.lineTo(points![i].dx, points![i].dy);
    }

    canvas.drawPath(path, paint);
  }

  void _paintDottedLine(
      Canvas canvas, double radius, double stepLength, Paint paint) {
    num startDistance = 0.0;
    final path = Path()..fillType = pathFillType!;

    for (var i = 0; i < points!.length - 1; i++) {
      var current = points![i];
      var next = points![i + 1];
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

    path.addOval(Rect.fromCircle(center: points!.last, radius: radius));
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

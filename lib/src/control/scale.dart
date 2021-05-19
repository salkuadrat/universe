import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:universe/src/shared.dart';

import '../map/map.dart';
import '../layer/layer.dart';

class Scale extends MapLayer {
  final Alignment alignment;
  final EdgeInsets? margin;
  final Color color;
  final double fontSize;
  final double strokeWidth;
  final double opacity;

  Scale({
    this.alignment = Alignment.topLeft,
    this.margin,
    this.color = const Color(0xFF546E7A),
    this.strokeWidth = 2.0,
    this.fontSize = 12,
    this.opacity = opacityDef,
  });

  final scale = [
    25000000,
    15000000,
    8000000,
    4000000,
    2000000,
    1000000,
    500000,
    250000,
    100000,
    50000,
    25000,
    15000,
    8000,
    4000,
    2000,
    1000,
    500,
    250,
    100,
    50,
    25,
    10,
    5
  ];

  @override
  Widget buildLayer(BuildContext context, MapStates map) {
    final zoom = map.zoom.round();
    final center = map.center;
    final distance = scale[math.max(0, math.min(20, zoom + 2))].toDouble();
    final target = map.controller.destination(distance, 90);
    final centerPoint = map.project(center);
    final targetPoint = map.project(target);

    final scaleWidth = targetPoint.x - centerPoint.x;
    final distanceStr = distance > 999
        ? '${(distance / 1000).toStringAsFixed(0)} km'
        : '${distance.toStringAsFixed(0)} m';

    final double viewTop = MediaQuery.of(context).viewPadding.top;
    final EdgeInsets margin =
        this.margin ?? EdgeInsets.only(top: viewTop + 12, left: 15);

    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: Container(
          margin: margin,
          child: Opacity(
            opacity: opacity,
            child: CustomPaint(
              painter: ScalePainter(
                text: distanceStr,
                scaleWidth: scaleWidth,
                textStyle: TextStyle(color: color, fontSize: fontSize),
                strokeColor: color,
                strokeWidth: strokeWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScalePainter extends CustomPainter {
  final String? text;
  final TextStyle? textStyle;
  final double? scaleWidth;
  final double? strokeWidth;
  final Color? strokeColor;

  ScalePainter({
    this.scaleWidth,
    this.text,
    this.textStyle,
    this.strokeWidth,
    this.strokeColor,
  });

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final paint = Paint()
      ..color = strokeColor!
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.square;

    final textPainter = TextPainter(
      text: TextSpan(style: textStyle, text: text),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(scaleWidth! / 2 - textPainter.width / 2, 0),
    );

    final vLineStart = textPainter.height;
    final vLineHeight = 5;

    // left vertical line
    canvas.drawLine(
      Offset(0, vLineStart),
      Offset(0, vLineStart + vLineHeight),
      paint,
    );

    // middle vertical line
    canvas.drawLine(
      Offset(scaleWidth! / 2 - strokeWidth! / 2, vLineStart + vLineHeight / 2),
      Offset(scaleWidth! / 2 - strokeWidth! / 2, vLineStart + vLineHeight),
      paint,
    );

    // right vertical line
    canvas.drawLine(
      Offset(scaleWidth!, vLineStart),
      Offset(scaleWidth!, vLineStart + vLineHeight),
      paint,
    );

    // bottom horizontal line
    canvas.drawLine(
      Offset(0, vLineStart + vLineHeight),
      Offset(scaleWidth!, vLineStart + vLineHeight),
      paint,
    );
  }

  @override
  bool shouldRepaint(ScalePainter oldPainter) => true;
}

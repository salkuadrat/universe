import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

import 'marker.dart';

class PolylinePainter extends CustomPainter {

  final Polyline polyline;

  PolylinePainter(this.polyline);

  bool get hasOffsets => 
    polyline.offsets != null && polyline.offsets.isNotEmpty;

  bool get noOffsets => !hasOffsets;

  bool get hasGradients => 
    polyline.gradientColors != null && polyline.gradientColors.isNotEmpty;
  
  bool get noGradients => !hasGradients;
  
  @override
  void paint(Canvas canvas, Size size) {
    if(noOffsets) {
      return;
    }

    final rect = Offset.zero & size;
    canvas.clipRect(rect);

    final paint = Paint()
      ..strokeWidth = polyline.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..blendMode = BlendMode.srcOver;
    
    hasGradients 
      ? paint.shader = _gradient() 
      : paint.color = polyline.color;

    final filterPaint = Paint()
      ..color = polyline.borderColor.withOpacity(1.0)
      ..strokeWidth = polyline.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..blendMode = BlendMode.dstOut;  

    Paint borderPaint;

    if(polyline.borderStrokeWidth > 0.0) {
      borderPaint = Paint()
        ..color = polyline.borderColor
        ..strokeWidth = polyline.strokeWidth + polyline.borderStrokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..blendMode = BlendMode.srcOver;
    }

    double radius = paint.strokeWidth / 2;
    double borderRadius = (borderPaint?.strokeWidth ?? 0) / 2;

    if(polyline.isDotted) {
      
    }

  }

  ui.Gradient _gradient() => ui.Gradient.linear(
    polyline.offsets.first, 
    polyline.offsets.last, 
    polyline.gradientColors,
    _stops(),
  );

  List<double> _stops() {
    if(polyline.gradientStops != null && polyline.gradientStops.length == polyline.gradientColors.length) {
      return polyline.gradientStops;
    }

    final colorsStopInterval = 1.0 / polyline.gradientColors.length;
    return polyline.gradientColors.map((color) => 
      polyline.gradientColors.indexOf(color) * colorsStopInterval).toList();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../layer.dart';

class PolylineLayerOptions extends PathLayerOptions {

  final List<Color> gradientStrokeColors;
  final List<double> gradientStrokeStops;
  final bool isDotted;
  final num smoothFactor;
  final bool culling;

  const PolylineLayerOptions({
    bool stroke = strokeDef,
    Color strokeColor,
    num strokeWidth = strokeWidthDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    this.gradientStrokeColors = gradientColorsDef,
    this.gradientStrokeStops = gradientStopsDef,
    this.isDotted = isDottedDef,
    this.smoothFactor = smoothFactorDef,
    this.culling = cullingDef,
    bool interactive = interactiveDef,
  }) : super(
    stroke: stroke,
    strokeColor: strokeColor,
    strokeWidth: strokeWidth,
    strokeOpacity: strokeOpacity,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    fill: false,
    interactive: interactive,
  );
}
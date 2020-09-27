import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../layer.dart';

class PolygonLayerOptions extends PathLayerOptions {

  final bool isDotted;
  final List<Color> gradientStrokeColors;
  final List<double> gradientStrokeStops;
  final List<Color> gradientFillColors;
  final List<double> gradientFillStops;
  final num smoothFactor;
  final bool culling;

  const PolygonLayerOptions({
    bool stroke = strokeDef,
    Color strokeColor,
    num strokeWidth = strokeWidthDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = StrokeCap.round,
    StrokeJoin strokeJoin = StrokeJoin.round,
    Color fillColor,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    this.isDotted = isDottedDef,
    this.gradientStrokeColors = gradientColorsDef,
    this.gradientStrokeStops = gradientStopsDef,
    this.gradientFillColors = gradientColorsDef,
    this.gradientFillStops = gradientStopsDef,
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
    fill: true,
    fillColor: fillColor,
    fillOpacity: fillOpacity,
    fillType: fillType,
    interactive: interactive,
  );
}
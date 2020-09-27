import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../layer.dart';

class RectangleLayerOptions extends PolygonLayerOptions {
  const RectangleLayerOptions({
    bool stroke = strokeDef,
    Color strokeColor,
    num strokeWidth = strokeWidthDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    Color fillColor,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    num smoothFactor = smoothFactorDef,
    bool culling = cullingDef,
    bool interactive = interactiveDef,
  }) : super(
    stroke: stroke,
    strokeColor: strokeColor,
    strokeWidth: strokeWidth,
    strokeOpacity: strokeOpacity,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    fillColor: fillColor,
    fillOpacity: fillOpacity,
    fillType: fillType,
    smoothFactor: smoothFactor,
    culling: culling,
    interactive: interactive,
  );
}
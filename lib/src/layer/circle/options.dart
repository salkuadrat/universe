import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../path/path.dart';

/// This options can be overridden by individual style options 
/// at individual Circle instance.
class CircleLayerOptions extends PathLayerOptions {
  const CircleLayerOptions({
    bool stroke = strokeDef,
    Color strokeColor,
    num strokeWidth = strokeWidthDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    bool fill = true,
    Color fillColor,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    bool interactive = interactiveDef,
  }) : super(
    stroke: stroke,
    strokeColor: strokeColor,
    strokeWidth: strokeWidth,
    strokeOpacity: strokeOpacity,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    fill: fill,
    fillColor: fillColor,
    fillOpacity: fillOpacity,
    fillType: fillType,
    interactive: interactive,
  );
}
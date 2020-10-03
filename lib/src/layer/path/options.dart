import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../layer.dart';

class PathLayerOptions extends LayerOptions {

  final bool stroke;
  final Color strokeColor;
  final double strokeWidth;
  final double strokeOpacity;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;
  final bool fill;
  final Color fillColor;
  final double fillOpacity;
  final PathFillType fillType;

  const PathLayerOptions({
    this.stroke = strokeDef, 
    this.strokeColor = strokeColorDef, 
    this.strokeWidth = strokeWidthDef, 
    this.strokeOpacity = strokeOpacityDef, 
    this.strokeCap = strokeCapDef, 
    this.strokeJoin = strokeJoinDef, 
    this.fill = fillDef, 
    this.fillColor = fillColorDef, 
    this.fillOpacity = fillOpacityDef, 
    this.fillType = fillTypeDef,
    bool interactive = interactiveDef,
  }) : super(interactive: interactive);
}
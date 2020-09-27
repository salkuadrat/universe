import 'package:flutter/rendering.dart';
import 'package:universe/src/shared.dart';

import '../base/options.dart';

class PathLayerOptions extends LayerOptions {

  final bool stroke;
  final Color color;
  final double weight;
  final double opacity;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;
  final bool fill;
  final Color fillColor;
  final double fillOpacity;
  final PathFillType fillType;

  const PathLayerOptions({
    this.stroke=strokeDef, 
    this.color, 
    this.weight=weightDef, 
    this.opacity=opacityDef, 
    this.strokeCap=strokeCapDef, 
    this.strokeJoin=strokeJoinDef, 
    this.fill=false, 
    this.fillColor, 
    this.fillOpacity=fillOpacityDef, 
    this.fillType=fillTypeDef,
    bool interactive=interactiveDef,
    String attribution=attributionDef,
  }) : super(interactive: interactive, attribution: attribution);
}
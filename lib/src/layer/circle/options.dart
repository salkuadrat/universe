import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../path/options.dart';
import 'marker.dart';

/// This options can be overridden by individual style options 
/// at individual Circle instance.
class CircleLayerOptions extends PathLayerOptions {
  final Circle circle;

  const CircleLayerOptions(this.circle, {
    bool stroke = strokeDef,
    Color color,
    num weight = weightDef,
    double opacity = opacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    bool fill = true,
    Color fillColor,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) : super(
    stroke: stroke,
    color: color,
    weight: weight,
    opacity: opacity,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    fill: fill,
    fillColor: fillColor,
    fillOpacity: fillOpacity,
    fillType: fillType,
    interactive: interactive, 
    attribution: attribution,
  );
}

class CirclesLayerOptions extends PathLayerOptions {
  final List<Circle> circles;
  
  const CirclesLayerOptions(this.circles, {
    bool stroke = strokeDef,
    Color color,
    num weight = weightDef,
    double opacity = opacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    bool fill = true,
    Color fillColor,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) : super(
    stroke: stroke,
    color: color,
    weight: weight,
    opacity: opacity,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    fill: fill,
    fillColor: fillColor,
    fillOpacity: fillOpacity,
    fillType: fillType,
    interactive: interactive, 
    attribution: attribution,
  );
}
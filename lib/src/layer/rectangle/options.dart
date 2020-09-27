import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../polyline/options.dart';
import 'marker.dart';

class RectangleLayerOptions extends PolylineLayerOptions {

  final Rectangle rectangle;

  const RectangleLayerOptions(this.rectangle, {
    bool stroke = strokeDef,
    Color color,
    num weight = weightDef,
    double opacity = opacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    Color fillColor,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    num smoothFactor = smoothFactorDef,
    bool noClip = noClipDef,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) : super(
    null,
    stroke: stroke,
    color: color,
    weight: weight,
    opacity: opacity,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    fill: true,
    fillColor: fillColor,
    fillOpacity: fillOpacity,
    fillType: fillType,
    smoothFactor: smoothFactor,
    noClip: noClip,
    interactive: interactive, 
    attribution: attribution,
  );
}

class MultiRectangleLayerOptions extends MultiPolylineLayerOptions {

  final List<Rectangle> rectangles;

  const MultiRectangleLayerOptions(this.rectangles, {
    bool stroke = strokeDef,
    Color color,
    num weight = weightDef,
    double opacity = opacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    Color fillColor,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    num smoothFactor = smoothFactorDef,
    bool noClip = noClipDef,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) : super(
    null,
    stroke: stroke,
    color: color,
    weight: weight,
    opacity: opacity,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    fill: true,
    fillColor: fillColor,
    fillOpacity: fillOpacity,
    fillType: fillType,
    smoothFactor: smoothFactor,
    noClip: noClip,
    interactive: interactive, 
    attribution: attribution,
  );
}
import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../path/options.dart';
import 'marker.dart';

class PolylineLayerOptions extends PathLayerOptions {
  final Polyline polyline;
  final num smoothFactor;
  final bool noClip;

  const PolylineLayerOptions(this.polyline, {
    bool stroke = strokeDef,
    Color color,
    num weight = weightDef,
    double opacity = opacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    bool fill = false,
    Color fillColor,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    this.smoothFactor = smoothFactorDef,
    this.noClip = noClipDef,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) : super(
    stroke: stroke,
    color: color,
    weight: weight,
    opacity: opacity,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    fill: false,
    fillColor: fillColor,
    fillOpacity: fillOpacity,
    fillType: fillType,
    interactive: interactive, 
    attribution: attribution,
  );
}

class MultiPolylineLayerOptions extends PathLayerOptions {
  final List<Polyline> polylines;
  final num smoothFactor;
  final bool noClip;

  const MultiPolylineLayerOptions(this.polylines, {
    bool stroke = strokeDef,
    Color color,
    num weight = weightDef,
    double opacity = opacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    bool fill = false,
    Color fillColor,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    this.smoothFactor = smoothFactorDef,
    this.noClip = noClipDef,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) : super(
    stroke: stroke,
    color: color,
    weight: weight,
    opacity: opacity,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    fill: false,
    fillColor: fillColor,
    fillOpacity: fillOpacity,
    fillType: fillType,
    interactive: interactive, 
    attribution: attribution,
  );
}
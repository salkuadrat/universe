import 'package:flutter/rendering.dart';

import '../polyline/options.dart';
import 'marker.dart';

class PolygonLayerOptions extends PolylineLayerOptions {

  final Polygon polygon;

  const PolygonLayerOptions(this.polygon, {
    bool stroke = true,
    Color color,
    num weight = 3,
    double opacity = 1.0,
    StrokeCap strokeCap = StrokeCap.round,
    StrokeJoin strokeJoin = StrokeJoin.round,
    bool fill,
    Color fillColor,
    double fillOpacity = 0.2,
    PathFillType fillType = PathFillType.evenOdd,
    num smoothFactor=1.0,
    bool noClip=false,
    bool interactive = true,
    String attribution='',
  }) : super(
    null,
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

class MultiPolygonLayerOptions extends MultiPolylineLayerOptions {

  final List<Polygon> polygons;

  const MultiPolygonLayerOptions(this.polygons, {
    bool stroke = true,
    Color color,
    num weight = 3,
    double opacity = 1.0,
    StrokeCap strokeCap = StrokeCap.round,
    StrokeJoin strokeJoin = StrokeJoin.round,
    bool fill,
    Color fillColor,
    double fillOpacity = 0.2,
    PathFillType fillType = PathFillType.evenOdd,
    num smoothFactor=1.0,
    bool noClip=false,
    bool interactive = true,
    String attribution='',
  }) : super(
    null,
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
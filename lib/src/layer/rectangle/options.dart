import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../layer.dart';

class RectangleLayerOptions extends PolygonLayerOptions {
  const RectangleLayerOptions({
    bool stroke = strokePolygonDef,
    Color strokeColor = strokeColorDef,
    num strokeWidth = strokeWidthPolygonDef,
    double strokeOpacity = strokeOpacityPolygonDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    Color fillColor = fillColorDef,
    double fillOpacity = fillOpacityDef,
    PathFillType fillType = fillTypeDef,
    List<Color> gradientStrokeColors = gradientColorsDef,
    List<double> gradientStrokeStops = gradientStopsDef,
    List<Color> gradientFillColors = gradientColorsDef,
    List<double> gradientFillStops = gradientStopsDef,
    bool isDotted = isDottedDef,
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
    gradientStrokeColors: gradientStrokeColors,
    gradientStrokeStops: gradientStrokeStops,
    gradientFillColors: gradientFillColors,
    gradientFillStops: gradientFillStops,
    isDotted: isDotted,
    smoothFactor: smoothFactor,
    culling: culling,
    interactive: interactive,
  );
}
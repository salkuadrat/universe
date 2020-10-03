import 'package:flutter/rendering.dart';

import '../../core/core.dart';
import '../layer.dart';

class Polygon extends Polyline{

  final bool stroke;
  final Color fillColor;
  final double fillOpacity;
  final PathFillType fillType;
  final List<Color> gradientFillColors;
  final List<double> gradientFillStops;
  final List<List<LatLng>> holeLatLngList;
  final bool disableHoles;

  bool get isEmpty => latlngs == null || latlngs.isEmpty;
  bool get isNotEmpty => latlngs != null && latlngs.isNotEmpty;

  bool get isValid => isNotEmpty && latlngs.length > 2;
  bool get isNotValid => !isValid;
  
  LatLngBounds get bounds => LatLngBounds.from(latlngs);

  // can accept Polygon([LatLng(), LatLng(), ...]) or Polygon([[], [], ...])
  Polygon(List<dynamic> latlngs, {
    this.stroke,
    Color strokeColor, 
    double strokeWidth, 
    StrokeCap strokeCap,
    StrokeJoin strokeJoin,
    this.fillColor,
    this.fillOpacity,
    this.fillType,
    List<Color> gradientStrokeColors, 
    List<double> gradientStrokeStops,
    this.gradientFillColors,
    this.gradientFillStops,
    bool isDotted,
    this.holeLatLngList,
    this.disableHoles = false,
  }): super(
    latlngs,
    strokeColor: strokeColor,
    strokeWidth: strokeWidth,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    gradientStrokeColors: gradientStrokeColors,
    gradientStrokeStops: gradientStrokeStops,
    isDotted: isDotted,
  );

  factory Polygon.from(dynamic value) {
    if(value is Polygon) return value;
    if(value is List<dynamic>) return Polygon(value);
    return Polygon([]);
  }

  @override
  String toString() => 'Polygon($latlngs)';

}
import 'package:flutter/rendering.dart';

import '../../core/core.dart';
import '../layer.dart';

class Rectangle extends Polygon {

  bool get isEmpty => latlngs == null || latlngs.isEmpty;
  bool get isNotEmpty => latlngs != null && latlngs.isNotEmpty;

  bool get isValid => 
    isNotEmpty && 
    latlngs.length == 2 && 
    latlngs[0] != latlngs[1];
  
  bool get isNotValid => !isValid;
  
  LatLngBounds get bounds => LatLngBounds.from(latlngs);

  List<LatLng> get validLatLngs {
    LatLngBounds bounds = this.bounds;
    return [ 
      bounds.northWest, 
      bounds.northEast, 
      bounds.southEast, 
      bounds.southWest,
    ];
  }

  Rectangle(List<dynamic> latlngs, {
    Color strokeColor, 
    double strokeWidth, 
    StrokeCap strokeCap,
    StrokeJoin strokeJoin,
    Color fillColor,
    double fillOpacity,
    PathFillType fillType,
    bool isDotted,
    List<Color> gradientStrokeColors, 
    List<double> gradientStrokeStops,
    List<Color> gradientFillColors,
    List<double> gradientFillStops,
    List<List<LatLng>> holeLatLngList,
    bool disableHoles = false,
  }) : super(
    latlngs,
    strokeColor: strokeColor,
    strokeWidth: strokeWidth,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    fillColor: fillColor,
    fillOpacity: fillOpacity,
    fillType: fillType,
    isDotted: isDotted,
    gradientStrokeColors: gradientStrokeColors,
    gradientStrokeStops: gradientStrokeStops,
    gradientFillColors: gradientFillColors,
    gradientFillStops: gradientFillStops,
    holeLatLngList: holeLatLngList,
    disableHoles: disableHoles,
  ) {
    assert(latlngs != null && latlngs.length == 2);
  }

  factory Rectangle.from(dynamic value) {
    if(value is Rectangle) return value;
    if(value is List<dynamic>) return Rectangle(value);
    return Rectangle([]);
  }

  @override
  String toString() => 'Rectangle($latlngs)';

}
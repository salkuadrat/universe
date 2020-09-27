import 'package:flutter/rendering.dart';

import '../../core/core.dart';

class Polyline {
  
  final List<LatLng> latlngs;
  final Color strokeColor;
  final double strokeWidth;
  final double strokeOpacity;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;
  final List<Color> gradientStrokeColors;
  final List<double> gradientStrokeStops;
  final bool isDotted;

  bool get isEmpty => latlngs == null || latlngs.isEmpty;
  bool get isNotEmpty => latlngs != null && latlngs.isNotEmpty;

  LatLngBounds get bounds => LatLngBounds.from(latlngs);

  // can accept Polyline([LatLng(), LatLng(), ...]) or Polygon([[], [], ...])
  Polyline(List<dynamic> latlngs, {
    this.strokeColor, 
    this.strokeWidth, 
    this.strokeOpacity,
    this.strokeCap,
    this.strokeJoin,
    this.gradientStrokeColors, 
    this.gradientStrokeStops,
    this.isDotted,
  }): this.latlngs = latlngs.map((latlng) => LatLng.from(latlng)).toList();

  factory Polyline.from(dynamic value) {
    if(value is Polyline) return value;
    if(value is List<dynamic>) return Polyline(value);
    return Polyline([]);
  }
}
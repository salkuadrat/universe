import 'package:flutter/widgets.dart';

import '../../core/core.dart';

/// Circle can have their own style to override style from LayerOptions.
/// 
/// This is to to handle the case when you use CirclesLayer 
/// with many circle take their style from CirclesLayerOptions,
/// but some small part of them need to have its own style.
/// 
/// Otherwise, it's better to use CircleLayerOptions to set circle style.
/// 
class Circle {
  final LatLng latlng;
  final bool stroke;
  final Color strokeColor;
  final num strokeWidth;
  final double strokeOpacity;
  final bool fill;
  final Color fillColor;
  final double fillOpacity;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;

  double radius;
  double radiusInMeter;

  LatLng get center => latlng;
  
  Circle(dynamic latlng, num radius, {
    num radiusInMeter,
    this.stroke,
    this.strokeColor, 
    this.strokeWidth, 
    this.strokeOpacity,
    this.fill, 
    Color fillColor, 
    this.fillOpacity,
    this.strokeCap,
    this.strokeJoin,
  }) : this.latlng = LatLng.from(latlng),
       this.radius = radius?.toDouble(),
       this.radiusInMeter = radiusInMeter?.toDouble(),
       this.fillColor = fillColor ?? strokeColor;
  
  factory Circle.from(dynamic value, [num radius = 0.0]) {
    if(value is Circle) {
      if(radius > 0.0) value.radius = radius;
      return value;
    }
    
    if(value is LatLng) return Circle(value, radius);
    return Circle(LatLng.from(value), radius);
  }

  @override
  String toString() => 'Circle($latlng, radius $radius)';
}
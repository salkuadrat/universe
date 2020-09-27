import 'package:flutter/widgets.dart';

import '../../core/latlng/latlng.dart';

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
  final double opacity;
  final Color color;
  final bool stroke;
  final num weight;
  final bool fill;
  final Color fillColor;
  final double fillOpacity;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;
  final bool isRadiusInMeter;

  double radius;
  Offset center = Offset.zero;
  
  Circle(dynamic latlng, num radius, {
    this.isRadiusInMeter=false,
    this.color, 
    this.stroke,
    this.weight, 
    this.opacity,
    this.fill = false, 
    Color fillColor, 
    this.fillOpacity,
    this.strokeCap,
    this.strokeJoin,
  }) : this.latlng = LatLng.from(latlng),
       this.radius = radius?.toDouble(),
       this.fillColor = fillColor ?? color;
}
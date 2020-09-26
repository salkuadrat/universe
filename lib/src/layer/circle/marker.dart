import 'package:flutter/widgets.dart';

import '../../core/latlng/latlng.dart';

class Circle {
  final LatLng latlng;
  final double opacity;
  final Color color;
  final bool stroke;
  final double weight;
  final bool fill;
  final Color fillColor;
  final double fillOpacity;
  final bool isRadiusInMeter;
  final bool interactive;

  double radius;
  Offset center = Offset.zero;
  
  Circle(dynamic latlng, num radius, {
    this.color=const Color(0xff3388ff), 
    this.stroke = true,
    num weight = 3, 
    num opacity = 1,
    this.fill = false, 
    Color fillColor, 
    num fillOpacity = 0.2,
    this.interactive = true,
    this.isRadiusInMeter=false,
  }) : this.latlng = LatLng.from(latlng), 
       this.radius = radius.toDouble(),
       this.weight = weight.toDouble(),
       this.opacity = opacity?.toDouble(),
       this.fillColor = fillColor ?? color,
       this.fillOpacity = fillOpacity?.toDouble();
}
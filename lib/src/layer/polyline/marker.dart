import 'package:colours/colours.dart';
import 'package:flutter/rendering.dart';

import '../../core/geometry/latlng_bounds.dart';
import '../../core/latlng/latlng.dart';

class Polyline {
  final List<LatLng> positions;
  
  final Color color;
  final Color borderColor;
  final double strokeWidth;
  final double borderStrokeWidth;
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final bool isDotted;

  List<Offset> offsets = [];
  LatLngBounds bounds;

  Polyline({
    this.positions, 
    this.color = Colours.white54, 
    this.borderColor = Colours.black26, 
    this.strokeWidth = 1.0, 
    this.borderStrokeWidth = 0.0, 
    this.gradientColors, 
    this.gradientStops,
    this.isDotted = false,
  });
}
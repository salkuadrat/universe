/* import 'dart:math' as Math;

import 'geobounds.dart';
import 'latlng/latlng.dart';

class GeoPosition extends LatLng {
  GeoPosition(double latitude, double longitude, [double altitude]) 
    : super(latitude, longitude, altitude);
  
  factory GeoPosition.from(dynamic value) {
    if(value is GeoPosition) return value;
    return (LatLng.from(value) as GeoPosition);
  }

  /// Returns `true` if the given position is at the same position 
  /// (within a small margin of error). 
  /// 
  /// The margin of error can be overridden by setting `maxMargin` to a small number.
  /// 
  /// can accept other: GeoPosition(20.0, 30.0) or other: [20.0, 30.0]
  bool equal(other, {maxMargin=1.0E-9}) {
    GeoPosition o = GeoPosition.from(other);

    double margin = Math.max(
      (this.latitude - o.latitude).abs(), 
      (this.longitude - o.longitude).abs(),
    );

    return margin <= maxMargin;
  }
  
  @override
  int get hashCode => lat.hashCode ^ lng.hashCode ^ alt.hashCode;
  
  /// Returns `true` if the given position is at the same precise position 
  /// (without margin of error). 
  @override
  bool operator ==(other) => other is GeoPosition && 
    lat == other.lat && lng == other.lng && alt == other.alt;
}

/// Position's type for [PositionCallback].
class MapPosition {
  GeoPosition center;
  final GeoBounds bounds;
  final double zoom;
  final bool hasGesture;

  // can accept center: GeoPosition(20.0, 30.0) or center: [20.0, 30.0]
  MapPosition({dynamic center, this.bounds, this.zoom, this.hasGesture = false}) {
    this.center = GeoPosition.from(center);
  }
} */
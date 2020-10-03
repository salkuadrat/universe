import 'package:tuple/tuple.dart';
import 'dart:math' as math;

import '../core.dart';

export 'projection.dart';
export 'projection.mercator.dart';
export 'projection.pj4.dart';
export 'projection.simple.dart';
export 'projection.spherical.mercator.dart';

abstract class Projection {

  final Tuple2<double, double> latBounds;
  final Tuple2<double, double> lngBounds;
  final Bounds bounds;

  bool get hasLatBounds => latBounds != null;
  bool get hasLngBounds => lngBounds != null;

  const Projection({
    this.bounds,
    this.latBounds=const Tuple2(-90.0, 90.0),
    this.lngBounds=const Tuple2(-180.0, 180.0),
  });

  /// Projects geographical coordinates into coordinates in units accepted for 
  /// this CRS (e.g. meters for EPSG:3857, for passing it to WMS services).
  UPoint project(LatLng position);

  /// Given a projected coordinate returns the corresponding GeoPosition. 
  /// The inverse of `project`.
  LatLng unproject(UPoint point);
  
  
  double _wrap(Comparable start, Comparable end, double value) {
    if(value.compareTo(start) < 0) return start;
    if(value.compareTo(end) > 0) return end;
    return value;
  }

  double wrapLat(double value) {
    final min = math.min(latBounds.item1, latBounds.item2);
    final max = math.max(latBounds.item1, latBounds.item2);
    return _wrap(min, max, value);
  }

  double wrapLng(double value) {
    final min = math.min(lngBounds.item1, lngBounds.item2);
    final max = math.max(lngBounds.item1, lngBounds.item2);
    return _wrap(min, max, value);
  }
}
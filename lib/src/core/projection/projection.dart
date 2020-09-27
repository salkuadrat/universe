import 'package:tuple/tuple.dart';

import '../../core/latlng/latlng.dart';
import '../geometry/bounds.dart';
import '../geometry/point.dart';

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
    return _wrap(latBounds.item1, latBounds.item2, value);
  }

  double wrapLng(double value) {
    return _wrap(lngBounds.item1, lngBounds.item2, value);
  }
}
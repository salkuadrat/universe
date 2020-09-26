import 'package:tuple/tuple.dart';

import '../../core/latlng/latlng.dart';
import '../geometry/bounds.dart';
import '../geometry/point.dart';
import 'projection.dart';

/// Equirectangular, or Plate Carree projection — the most simple projection, 
/// mostly used by GIS enthusiasts. 
/// 
/// Directly maps `x` as longitude, and `y` as latitude. 
/// Also suitable for flat worlds, e.g. game maps. 
/// Used by the `EPSG:4326` and `Simple` CRS.
class SimpleProjection extends Projection {
  
  const SimpleProjection({Tuple2<double, double> latBounds, Tuple2<double, double> lngBounds}) 
    : super(latBounds: latBounds, lngBounds: lngBounds);

  @override
  Bounds get bounds => Bounds(
    GeoPoint(-180.0, -90.0), 
    GeoPoint(180.0, 90.0),
  );
  
  @override
  GeoPoint project(LatLng position) {
    return GeoPoint(position.longitude, position.latitude);
  }

  @override
  LatLng unproject(GeoPoint point) {
    return LatLng(wrapLat(point.y), wrapLng(point.x));
  }
}
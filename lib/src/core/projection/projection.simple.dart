import 'package:tuple/tuple.dart';

import '../core.dart';

/// Equirectangular, or Plate Carree projection — the most simple projection, 
/// mostly used by GIS enthusiasts. 
/// 
/// Directly maps `x` as longitude, and `y` as latitude. 
/// Also suitable for flat worlds, e.g. game maps. 
/// Used by the `EPSG:4326` and `Simple` CRS.
class SimpleProjection extends Projection {
  
  const SimpleProjection({Tuple2<double, double>? latBounds, Tuple2<double, double>? lngBounds}) 
    : super(latBounds: latBounds, lngBounds: lngBounds);

  @override
  Bounds get bounds => Bounds(
    UPoint(-180.0, -90.0), 
    UPoint(180.0, 90.0),
  );
  
  @override
  UPoint project(LatLng? position) {
    return UPoint(position!.lng, position.lat);
  }

  @override
  LatLng unproject(UPoint point) {
    return LatLng(wrapLat(point.y), wrapLng(point.x));
  }
}
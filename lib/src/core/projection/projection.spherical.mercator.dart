import 'dart:math' as Math;
import 'package:tuple/tuple.dart';

import '../../core/latlng/latlng.dart';
import '../../shared.dart';
import '../geometry/bounds.dart';
import '../geometry/point.dart';
import 'projection.dart';

class SphericalMercator extends Projection {
  static const double R = EQUATOR_RADIUS;
  static const double MAX_LATITUDE = 85.0511287798;
  static const double D = R * PI;

  const SphericalMercator({Tuple2<double, double> latBounds, Tuple2<double, double> lngBounds}) 
    : super(latBounds: latBounds, lngBounds: lngBounds);

  @override
  Bounds get bounds => Bounds(
    GeoPoint(-D, -D),
    GeoPoint(D, D),
  );

  @override
  GeoPoint project(LatLng position) {
    double d = PI / 180;
    double max = MAX_LATITUDE;
    double lat = Math.max(Math.min(max, position.latitude), -max);
    double sin = Math.sin(lat * d);

    return GeoPoint(
      R * position.longitude * d, 
      R * Math.log((1 + sin) / (1 - sin)) / 2,
    );
  }

  @override
  LatLng unproject(GeoPoint point) {
    double d = 180 / PI;

    return LatLng(
      wrapLat((2 * Math.atan(Math.exp(point.y / R)) - (PI / 2)) * d),
      wrapLng(point.x * d / R),
    );
  }
}
// ignore_for_file: constant_identifier_names

import 'dart:math' as math;
import 'package:tuple/tuple.dart';

import '../../shared.dart';
import '../core.dart';

class SphericalMercator extends Projection {
  static const double R = EQUATOR_RADIUS;
  static const double MAX_LATITUDE = 85.0511287798;
  static const double D = R * PI;

  const SphericalMercator({
    Tuple2<double, double>? latBounds,
    Tuple2<double, double>? lngBounds,
  }) : super(latBounds: latBounds, lngBounds: lngBounds);

  @override
  Bounds get bounds => Bounds(
        const UPoint(-D, -D),
        const UPoint(D, D),
      );

  @override
  UPoint project(LatLng? position) {
    double d = PI / 180;
    double max = MAX_LATITUDE;
    double lat = math.max(math.min(max, position!.lat), -max);
    double sin = math.sin(lat * d);

    return UPoint(
      R * position.lng * d,
      R * math.log((1 + sin) / (1 - sin)) / 2,
    );
  }

  @override
  LatLng unproject(UPoint point) {
    double d = 180 / PI;

    return LatLng(
      wrapLat((2 * math.atan(math.exp(point.y / R)) - (PI / 2)) * d),
      wrapLng(point.x * d / R),
    );
  }
}

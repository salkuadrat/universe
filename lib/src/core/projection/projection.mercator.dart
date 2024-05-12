// ignore_for_file: constant_identifier_names

import 'dart:math' as math;
import 'package:tuple/tuple.dart';

import '../../shared.dart';
import '../core.dart';

class Mercator extends Projection {
  static const double R = EQUATOR_RADIUS;
  static const double R_MINOR = POLAR_RADIUS;
  static const double MAX_LATITUDE = 85.0511287798;

  const Mercator({
    Tuple2<double, double>? latBounds,
    Tuple2<double, double>? lngBounds,
  }) : super(latBounds: latBounds, lngBounds: lngBounds);

  @override
  Bounds get bounds => Bounds(
        const UPoint(-20037508.34279, -15496570.73972),
        const UPoint(20037508.34279, 18764656.23138),
      );

  @override
  UPoint project(LatLng? position) {
    double d = PI / 180;
    double y = position!.lat * d;
    double tmp = R_MINOR / R;
    double e = math.sqrt(1 - tmp * tmp);
    double con = e * math.sin(y);

    double ts =
        math.tan(PI / 4 - y / 2) / math.pow((1 - con) / (1 + con), e / 2);
    y = -R * math.log(math.max(ts, 1E-10));

    return UPoint(position.lng * d * R, y);
  }

  @override
  LatLng unproject(UPoint point) {
    double d = 180 / PI;
    double tmp = R_MINOR / R;
    double e = math.sqrt(1 - tmp * tmp);
    double ts = math.exp(-point.y / R);
    double phi = PI / 2 - 2 * math.atan(ts);
    double dphi = 0.1;
    double con = 0;

    for (int i = 0; i < 15 && dphi.abs() > 1e-7; i++) {
      con = e * math.sin(phi);
      con = math.pow((1 - con) / (1 + con), e / 2) as double;
      dphi = PI / 2 - 2 * math.atan(ts * con) - phi;
      phi += dphi;
    }

    return LatLng(wrapLat(phi * d), wrapLng(point.x * d / R));
  }
}

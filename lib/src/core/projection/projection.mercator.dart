import 'dart:math' as Math;
import 'package:tuple/tuple.dart';

import '../../shared.dart';
import '../core.dart';

class Mercator extends Projection {
  
  static const double R = EQUATOR_RADIUS;
  static const double R_MINOR = POLAR_RADIUS;
  static const double MAX_LATITUDE = 85.0511287798;

  const Mercator({Tuple2<double, double>? latBounds, Tuple2<double, double>? lngBounds}) 
    : super(latBounds: latBounds, lngBounds: lngBounds);

  @override
  Bounds get bounds => Bounds(
    UPoint(-20037508.34279, -15496570.73972),
    UPoint(20037508.34279, 18764656.23138),
  );

  @override
  UPoint project(LatLng? position) {
    double d = PI / 180;
    double y = position!.latitude! * d;
    double tmp = R_MINOR / R;
    double e = Math.sqrt(1 - tmp * tmp);
    double con = e * Math.sin(y);

    double ts = Math.tan(PI / 4 - y / 2) / Math.pow((1 - con) / (1 + con), e / 2);
    y = -R * Math.log(Math.max(ts, 1E-10));

    return UPoint(position.longitude! * d * R, y);
  }

  @override
  LatLng unproject(UPoint point) {
    double d = 180 / PI;
    double tmp = R_MINOR / R;
    double e = Math.sqrt(1 - tmp * tmp);
    double ts = Math.exp(-point.y / R);
		double phi = PI / 2 - 2 * Math.atan(ts);

    for (int i = 0, dphi = 0.1 as int, con; i < 15 && dphi.abs() > 1e-7; i++) {
			con = e * Math.sin(phi) as int;
			con = Math.pow((1 - con) / (1 + con), e / 2) as int;
			dphi = PI / 2 - 2 * Math.atan(ts * con) - phi as int;
			phi += dphi;
		}

    return LatLng(wrapLat(phi * d), wrapLng(point.x * d / R));
  }
}
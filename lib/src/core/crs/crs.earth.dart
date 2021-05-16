import 'dart:math' as math;
import 'package:tuple/tuple.dart';

import '../../shared.dart';
import '../latlng/latlng.dart';
import 'crs.dart';

/// Serves as the base for CRS that are global such that they cover the earth.
/// Can only be used as the base for other CRS and cannot be used directly,
/// since it does not have a `code`, `projection` or `transformation`.
/// `distance()` returns meters.
class Earth extends BaseCrs {
  const Earth();

  @override
  String get code => 'CRS.Earth';

  // Mean Earth Radius, as recommended for use by
  // the International Union of Geodesy and Geophysics,
  // see http://rosettacode.org/wiki/Haversine_formula
  static double R = 6371000.0;

  @override
  double distance(LatLng position, LatLng destination) {
    double rad = PI / 180;
    double lat1 = position.lat * rad;
    double lat2 = destination.lat * rad;
    double sinDLat = math.sin((destination.lat - position.lat) * rad / 2);
    double sinDLon = math.sin((destination.lng - position.lng) * rad / 2);
    double a =
        sinDLat * sinDLat + math.cos(lat1) * math.cos(lat2) * sinDLon * sinDLon;
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return R * c;
  }

  @override
  Tuple2<double, double> get latBounds => Tuple2(-90.0, 90.0);

  @override
  Tuple2<double, double> get lngBounds => Tuple2(-180.0, 180.0);
}

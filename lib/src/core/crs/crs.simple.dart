import 'dart:math' as math;
import 'package:tuple/tuple.dart';

import '../core.dart';
import 'crs.dart';
import '../latlng/latlng.dart';
import '../projection/projection.dart';
import '../projection/projection.simple.dart';
import '../geometry/transformation.dart';

/// A simple CRS that maps longitude and latitude into `x` and `y` directly.
/// May be used for maps of flat surfaces (e.g. game maps).
///
/// Note that the `y` axis should still be inverted (going from bottom to top).
/// `distance()` returns simple euclidean distance.
class CrsSimple extends BaseCrs {
  const CrsSimple();

  @override
  String get code => 'CRS.Simple';

  @override
  Projection get projection =>
      SimpleProjection(latBounds: latBounds, lngBounds: lngBounds);

  @override
  Transformation get transformation => Transformation(1, 0, -1, 0);

  @override
  double scale(double? zoom) {
    return math.pow(2, zoom!).toDouble();
  }

  @override
  double zoom(double scale) {
    return (math.log(scale) / math.ln2).toDouble();
  }

  @override
  double distance(LatLng position, LatLng destination) {
    double dx = destination.lng - position.lng;
    double dy = destination.lat - position.lat;
    return math.sqrt(dx * dx + dy * dy);
  }

  @override
  bool get infinite => true;

  @override
  Tuple2<double, double>? get latBounds => Tuple2(-180.0, -90.0);

  @override
  Tuple2<double, double>? get lngBounds => Tuple2(180.0, 90.0);
}

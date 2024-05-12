// ignore_for_file: constant_identifier_names

import '../../shared.dart';
import '../geometry/transformation.dart';
import '../projection/projection.dart';
import 'crs.earth.dart';

/// The most common CRS for online maps, used by almost all free and
/// commercial tile providers.
///
/// Uses Spherical Mercator projection.
class Epsg3857 extends Earth {
  const Epsg3857();

  static const double SCALE = 0.5 / (PI * SphericalMercator.R);

  /// Code of this CRS.
  @override
  String get code => 'EPSG:3857';

  /// Projection value of this CRS.
  @override
  Projection get projection =>
      SphericalMercator(latBounds: latBounds, lngBounds: lngBounds);

  /// Transformation object of this CRS.
  @override
  Transformation get transformation => const Transformation(SCALE, 0.5, -SCALE, 0.5);

  // Epsg3857 latitude limits: https://epsg.io/3857
  // @override
  // Tuple2<double, double> get wrapLat => const Tuple2(-85.06, 85.06);
}

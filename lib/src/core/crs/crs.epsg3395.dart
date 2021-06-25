import '../../shared.dart';
import '../geometry/transformation.dart';
import '../projection/projection.dart';
import '../projection/projection.mercator.dart';
import 'crs.earth.dart';

/// The most common CRS used for rendering maps.
/// Rarely used by some commercial tile providers.
/// Uses Elliptical Mercator projection.
class Epsg3395 extends Earth {
  const Epsg3395();

  static const double SCALE = 0.5 / (PI * Mercator.R);

  /// Code of this CRS.
  @override
  String get code => 'EPSG:3395';

  /// Projection value of this CRS.
  @override
  Projection get projection =>
      Mercator(latBounds: latBounds, lngBounds: latBounds);

  /// Transformation object of this CRS.
  @override
  Transformation get transformation => Transformation(SCALE, 0.5, -SCALE, 0.5);
}

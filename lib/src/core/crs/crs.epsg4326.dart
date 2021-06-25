import '../projection/projection.dart';
import '../projection/projection.simple.dart';
import '../geometry/transformation.dart';
import 'crs.earth.dart';

/// A common CRS among GIS enthusiasts.
///
/// Uses simple Equirectangular projection.
class Epsg4326 extends Earth {
  const Epsg4326();

  /// Code of this CRS.
  @override
  String get code => 'EPSG:4326';

  /// Projection value of this CRS.
  @override
  Projection get projection =>
      SimpleProjection(latBounds: latBounds, lngBounds: lngBounds);

  /// Transformation object of this CRS.
  @override
  Transformation get transformation =>
      Transformation(1 / 180, 1, -1 / 180, 0.5);
}

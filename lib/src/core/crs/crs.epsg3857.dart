import '../../shared.dart';
import '../geometry/transformation.dart';
import '../projection/projection.dart';
import '../projection/projection.spherical.mercator.dart';
import 'crs.earth.dart';

/// The most common CRS for online maps, used by almost all free and 
/// commercial tile providers. 
/// 
/// Uses Spherical Mercator projection. 
class Epsg3857 extends Earth {
  
  const Epsg3857();
  
  static const double SCALE = 0.5 / (PI * SphericalMercator.R);

  @override
  String get code => 'EPSG:3857';

  @override
  Projection get projection => 
    SphericalMercator(latBounds: latBounds, lngBounds: lngBounds);

  @override
  Transformation get transformation => 
    Transformation(SCALE, 0.5, -SCALE, 0.5);

  // Epsg3857 latitude limits: https://epsg.io/3857
  // @override
  // Tuple2<double, double> get wrapLat => const Tuple2(-85.06, 85.06);
}
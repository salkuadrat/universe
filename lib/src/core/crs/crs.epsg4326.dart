import '../projection/projection.dart';
import '../projection/projection.simple.dart';
import '../geometry/transformation.dart';
import 'crs.earth.dart';

/// A common CRS among GIS enthusiasts. 
/// 
/// Uses simple Equirectangular projection.
class Epsg4326 extends Earth {
  
  const Epsg4326();

  @override
  String get code => 'EPSG:4326';

  @override
  Projection get projection => 
    SimpleProjection(latBounds: latBounds, lngBounds: lngBounds);

  @override
  Transformation get transformation => 
    Transformation(1 / 180, 1, -1 / 180, 0.5);

}
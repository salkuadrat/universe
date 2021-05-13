import '../core.dart';

export 'crs.dart';
export 'crs.base.dart';
export 'crs.earth.dart';
export 'crs.epsg3395.dart';
export 'crs.epsg3857.dart';
export 'crs.epsg4326.dart';
export 'crs.simple.dart';
export 'crs.proj4.dart';

class CRS {
  const CRS();
  
  static const Crs BASE = BaseCrs();
  static const Crs SIMPLE = CrsSimple();
  static const Crs EARTH = Earth();
  static const Crs EPSG4326 = Epsg4326();
  static const Crs EPSG3857 = Epsg3857();
  static const Crs EPSG3395 = Epsg3395();
}
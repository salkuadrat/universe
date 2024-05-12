// ignore_for_file: constant_identifier_names

import '../core.dart';

export 'crs.dart';
export 'crs.base.dart';
export 'crs.earth.dart';
export 'crs.epsg3395.dart';
export 'crs.epsg3857.dart';
export 'crs.epsg4326.dart';
export 'crs.simple.dart';
export 'crs.proj4.dart';

/// CRS colections
class CRS {
  /// Base CRS
  static const Crs BASE = BaseCrs();

  /// Simple CRS
  static const Crs SIMPLE = CrsSimple();

  /// Earth CRS
  static const Crs EARTH = Earth();

  /// EPSG4326 CRS
  static const Crs EPSG4326 = Epsg4326();

  /// EPSG3857 CRS
  static const Crs EPSG3857 = Epsg3857();

  /// EPSG3395 CRS
  static const Crs EPSG3395 = Epsg3395();
}

import 'dart:math' as math;
import 'package:tuple/tuple.dart';

import '../core.dart';

/// Object that defines coordinate reference systems for projecting
/// geographical points into pixel (screen) coordinates and back
/// (and to coordinates in other units for [WMS](https://en.wikipedia.org/wiki/Web_Map_Service) services).
/// See [Coordinate Reference System](http://en.wikipedia.org/wiki/Coordinate_reference_system).
///
/// The main objective of a CRS is to handle the conversion between surface
/// points of objects of different dimensions. In our case 3D and 2D objects.
abstract class Crs {
  const Crs();

  /// Crs code
  String get code;

  /// Crs projection
  Projection? get projection;

  /// Crs transformation
  Transformation? get transformation;

  /// Projects latlng coordinates into pixel coordinates for a given zoom.
  UPoint latlngToPoint(LatLng? position, double? zoom);

  /// The inverse of `latlngToPoint`.
  /// Projects pixel coordinates on a given zoom into latlng coordinates.
  LatLng? pointToLatLng(UPoint point, double? zoom);

  /// Projects geographical coordinates into coordinates
  /// in units accepted for this CRS (e.g. meters for EPSG:3857,
  /// for passing it to WMS services).
  UPoint? project(LatLng? latlng);

  /// Given a projected coordinate returns the corresponding LatLng.
  /// The inverse of project.
  LatLng? unproject(UPoint point);

  /// Returns the scale used when transforming projected coordinates into
  /// pixel coordinates for a particular zoom.
  ///
  /// For example, it returns `256 * 2^zoom` for Mercator-based CRS.
  double? scale(double? zoom);

  /// Inverse of `scale()`, returns the zoom level corresponding
  /// to a scale factor of `scale`.
  double zoom(double scale);

  /// Returns the projection's bounds scaled and transformed
  /// for the provided `zoom`.
  Bounds? getProjectedBounds(double? zoom);

  /// Returns the distance between two geographical coordinates.
  double? distance(LatLng position, LatLng destination);

  /// Returns a LatLng where lat and lng has been wrapped
  /// according to the CRS's wrapLat and wrapLng properties,
  /// if they are outside the CRS's bounds.
  LatLng wrapLatLng(LatLng latlng);

  /// Returns a LatLngBounds with the same size as the given one,
  /// ensuring that its center is within the CRS's bounds.
  ///
  /// Only accepts actual LatLngBounds instances, not List [].
  LatLngBounds wrapLatLngBounds(LatLngBounds bounds);

  /// Returns a `Tuple2<double 1, double 2)` where longitude has been wrapped
  /// according to the CRS's `wrapLng` properties,
  /// if they are outside the CRS's bounds.
  Tuple2<double, double>? get latBounds;

  /// Returns a `Tuple2<double 1, double 2)` where latitude has been wrapped
  /// according to the CRS's `wrapLat` properties,
  /// if they are outside the CRS's bounds.
  Tuple2<double, double>? get lngBounds;

  /// If true, the coordinate space will be unbounded (infinite in both axes).
  bool get infinite;
}

class BaseCrs extends Crs {
  const BaseCrs();

  @override
  String get code => 'CRS.Simple';

  @override
  Projection? get projection => null;

  @override
  Transformation get transformation => throw UnimplementedError();

  /// Projects latlng coordinates into pixel coordinates for a given zoom.
  @override
  UPoint latlngToPoint(LatLng? position, double? zoom) {
    try {
      var projectedPoint = projection!.project(position);
      double? scale = this.scale(zoom);
      return transformation.transform(projectedPoint, scale);
    } catch (e) {
      return const UPoint(0.0, 0.0);
    }
  }

  /// The inverse of `latlngToPoint`.
  /// Projects pixel coordinates on a given zoom into latlng coordinates.
  @override
  LatLng? pointToLatLng(UPoint point, double? zoom) {
    try {
      double? scale = this.scale(zoom);
      UPoint untransformedPoint = transformation.untransform(point, scale);
      return projection!.unproject(untransformedPoint);
    } catch (e) {
      return null;
    }
  }

  /// Projects geographical coordinates into coordinates
  /// in units accepted for this CRS (e.g. meters for EPSG:3857,
  /// for passing it to WMS services).
  @override
  UPoint? project(LatLng? latlng) {
    return projection?.project(latlng);
  }

  /// Given a projected coordinate returns the corresponding LatLng.
  /// The inverse of project.
  @override
  LatLng? unproject(UPoint point) {
    return projection?.unproject(point);
  }

  /// Returns the scale used when transforming projected coordinates into
  /// pixel coordinates for a particular zoom.
  ///
  /// For example, it returns `256 * 2^zoom` for Mercator-based CRS.
  @override
  double? scale(double? zoom) {
    return (256 * math.pow(2, zoom!)).toDouble();
  }

  /// Inverse of `scale()`, returns the zoom level corresponding
  /// to a scale factor of `scale`.
  @override
  double zoom(double scale) {
    return (math.log(scale / 256) / math.ln2).toDouble();
  }

  /// Returns the projection's bounds scaled and transformed
  /// for the provided `zoom`.
  @override
  Bounds? getProjectedBounds(double? zoom) {
    if (infinite) {
      return null;
    }

    Bounds bounds = projection!.bounds!;
    double? scale = this.scale(zoom);

    final min = transformation.transform(bounds.min, scale);
    final max = transformation.transform(bounds.max, scale);
    return Bounds(min, max);
  }

  /// Returns the distance between two geographical coordinates.
  @override
  double? distance(LatLng position, LatLng destination) {
    const distance = Distance();
    return distance(position, destination) as double?;
  }

  /// Returns a LatLng where lat and lng has been wrapped
  /// according to the CRS's wrapLat and wrapLng properties,
  /// if they are outside the CRS's bounds.
  @override
  LatLng wrapLatLng(LatLng latlng) {
    double? latitude = projection != null && projection!.hasLatBounds
        ? projection!.wrapLat(latlng.lat)
        : latlng.lat;

    double? longitude = projection != null && projection!.hasLngBounds
        ? projection!.wrapLng(latlng.lng)
        : latlng.lng;

    return LatLng(latitude, longitude);
  }

  /// Returns a `LatLngBounds` with the same size as the given one,
  /// ensuring that its center is within the CRS's bounds.
  ///
  /// Only accepts actual `LatLngBounds` instances, not list [].
  @override
  LatLngBounds wrapLatLngBounds(LatLngBounds bounds) {
    LatLng center = bounds.center;
    LatLng newCenter = wrapLatLng(center);
    double latShift = center.lat - newCenter.lat;
    double lngShift = center.lng - newCenter.lng;

    if (latShift == 0 && lngShift == 0) {
      return bounds;
    }

    LatLng sw = bounds.southWest!;
    LatLng ne = bounds.northEast!;
    LatLng newSw = LatLng(sw.lat - latShift, sw.lng - lngShift);
    LatLng newNe = LatLng(ne.lat - latShift, ne.lng - lngShift);

    return LatLngBounds(newSw, newNe);
  }

  @override
  Tuple2<double, double>? get latBounds => null;

  @override
  Tuple2<double, double>? get lngBounds => null;

  @override
  bool get infinite => false;
}

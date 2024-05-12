import 'package:proj4dart/proj4dart.dart' as pj4;
import 'package:tuple/tuple.dart';

import '../../core/latlng/latlng.dart';
import '../geometry/bounds.dart';
import '../geometry/point.dart';
import '../geometry/transformation.dart';
import '../projection/projection.dart';
import 'crs.dart';

/// Custom CRS
class Proj4Crs extends BaseCrs {
  /// Code of this CRS.
  @override
  final String code;

  /// Projection value of this CRS.
  @override
  final Projection projection;

  /// Transformation object of this CRS.
  @override
  final Transformation transformation;

  /// Infinite
  @override
  final bool infinite;

  /// Transformations list
  final List<Transformation>? transformations;

  /// Scale list
  final List<double?> scales;

  Proj4Crs._({
    required this.code,
    required this.projection,
    required this.transformation,
    required this.infinite,
    this.transformations,
    required this.scales,
  });

  factory Proj4Crs.fromFactory({
    required String code,
    required pj4.Projection pj4Projection,
    Transformation? transformation,
    List<UPoint>? origins,
    Bounds? bounds,
    List<double>? scales,
    List<double>? resolutions,
  }) {
    Projection projection = Pj4Projection(
      pj4Projection: pj4Projection,
      bounds: bounds,
      latBounds: const Tuple2(-90.0, 90.0),
      lngBounds: const Tuple2(-180.0, 180.0),
    );

    List<Transformation>? transformations;
    bool infinite = null == bounds;
    List<double> finalScales;

    if (scales != null && scales.isNotEmpty) {
      finalScales = scales;
    } else if (resolutions != null && resolutions.isNotEmpty) {
      finalScales = resolutions.map((r) => 1 / r).toList(growable: false);
    } else {
      throw Exception(
          'You should provide scales or resolutions to calculate scales');
    }

    if (origins == null || origins.isEmpty) {
      transformation ??= const Transformation(1, 0, -1, 0);
    } else {
      if (origins.length == 1) {
        var origin = origins[0];
        transformation = Transformation(1, -origin.x, -1, origin.y);
      } else {
        transformations =
            origins.map((p) => Transformation(1, -p.x, -1, p.y)).toList();

        transformation = null;
      }
    }

    return Proj4Crs._(
      code: code,
      projection: projection,
      transformation: transformation!,
      infinite: infinite,
      transformations: transformations,
      scales: finalScales,
    );
  }

  /// Converts a point on the sphere surface (with a certain zoom) in a
  /// map point.
  @override
  UPoint latlngToPoint(LatLng? position, double? zoom) {
    try {
      UPoint projectedPoint = projection.project(position);
      double? scale = this.scale(zoom);
      Transformation transformation = _getTransformationByZoom(zoom);

      return transformation.transform(projectedPoint, scale);
    } catch (e) {
      return const UPoint(0.0, 0.0);
    }
  }

  /// Converts a map point to the sphere coordinate (at a certain zoom).
  @override
  LatLng? pointToLatLng(UPoint point, double? zoom) {
    try {
      Transformation transformation = _getTransformationByZoom(zoom);
      double? scale = this.scale(zoom);
      UPoint untransformedPoint = transformation.untransform(point, scale);

      return projection.unproject(untransformedPoint);
    } catch (e) {
      return null;
    }
  }

  /// Rescales the bounds to a given zoom value.
  @override
  Bounds? getProjectedBounds(double? zoom) {
    if (infinite) {
      return null;
    }

    Bounds bounds = projection.bounds!;
    double? scale = this.scale(zoom);
    Transformation transformation = _getTransformationByZoom(zoom);

    var min = transformation.transform(bounds.min, scale);
    var max = transformation.transform(bounds.max, scale);
    return Bounds(min, max);
  }

  /// Zoom to Scale function.
  @override
  double? scale(double? zoom) {
    var zoomInt = zoom!.floor();

    if (zoom == zoomInt) {
      return scales[zoomInt];
    } else {
      var baseScale = scales[zoomInt]!;
      var nextScale = scales[zoomInt + 1]!;
      var scaleDiff = nextScale - baseScale;
      var zoomDiff = (zoom - zoomInt);
      return baseScale + scaleDiff * zoomDiff;
    }
  }

  /// Scale to Zoom function.
  @override
  double zoom(double scale) {
    // Find closest number in _scales, down
    double? downScale = _closestElement(scales, scale);
    int downZoom = scales.indexOf(downScale);

    // Check if scale is downScale => return array index
    if (scale == downScale) {
      return downZoom.toDouble();
    }

    if (downScale == null) {
      return double.negativeInfinity;
    }

    // Interpolate
    int nextZoom = downZoom + 1;
    double? nextScale = scales[nextZoom];

    if (nextScale == null) {
      return double.infinity;
    }

    double scaleDiff = nextScale - downScale;
    return (scale - downScale) / scaleDiff + downZoom;
  }

  /// Get the closest lowest element in an array
  double? _closestElement(List<double?> array, double element) {
    double? low;

    for (var i = array.length - 1; i >= 0; i--) {
      var curr = array[i]!;

      if (curr <= element && (null == low || low < curr)) {
        low = curr;
      }
    }

    return low;
  }

  /// returns Transformation object based on zoom
  Transformation _getTransformationByZoom(double? zoom) {
    if (transformations == null) {
      return transformation;
    }

    int zoomInt = zoom!.round();
    int lastIdx = transformations!.length - 1;

    return transformations![zoomInt > lastIdx ? lastIdx : zoomInt];
  }

  @override
  Tuple2<double, double> get latBounds => const Tuple2(-90.0, 90.0);

  @override
  Tuple2<double, double> get lngBounds => const Tuple2(-180.0, 180.0);
}

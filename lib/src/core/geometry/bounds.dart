import 'dart:math' as math;
import 'package:universe/src/core/geometry/size.dart';

import 'point.dart';

/// Rectangular bound delimited by orthogonal lines passing through two points.
class Bounds {
  final GeoPoint min;
  final GeoPoint max;

  // can accept Bounds(GeoPoint(20,30), GeoPoint(10, 10)) or 
  // Bounds([20, 30], [10, 10])
  factory Bounds(dynamic min, dynamic max) {
    Bounds bounds1 = Bounds._(min, max);
    Bounds bounds2 = bounds1.extend(min);
    return bounds2.extend(max);
  }
  
  const Bounds._(this.min, this.max);

  /// Creates a new [Bounds] obtained by expanding the current ones 
  /// with a new point.
  Bounds extend(dynamic _point) {
    GeoPoint point = GeoPoint.from(_point);
    GeoPoint _min;
    GeoPoint _max;

    if(min == null && max == null) {
      _min = point;
      _max = point;
    } else {
      double minX = math.min(point.x, min.x);
      double maxX = math.max(point.x, max.x);
      double minY = math.min(point.y, min.y);
      double maxY = math.max(point.y, max.y);

      _min = GeoPoint(minX, minY);
      _max = GeoPoint(maxX, maxY);
    }

    return Bounds._(_min, _max);
  }

  /// This [Bounds] central point.
  GeoPoint get center => GeoPoint(
    (min.x + max.x) / 2,
    (min.y + max.y) / 2,
  );

  /// A point that contains the difference between the point's axis projections.
  Size get size {
    return Size.from(max - min);
  }

  /// Bottom-Left corner's point.
  GeoPoint get bottomLeft => GeoPoint(min.x, max.y);

  /// Top-Right corner's point.
  GeoPoint get topRight => GeoPoint(max.x, min.y);

  /// Top-Left corner's point.
  GeoPoint get topLeft => min;

  /// Bottom-Right corner's point.
  GeoPoint get bottomRight => max;

  bool contains(GeoPoint point) {
    var min = point;
    var max = point;
    return containsBounds(Bounds(min, max));
  }

  bool containsBounds(Bounds b) {
    return 
      (b.min.x >= min.x) &&
      (b.max.x <= max.x) &&
      (b.min.y >= min.y) &&
      (b.max.y <= max.y);
  }

  bool containsPartialBounds(Bounds b) {
    return 
      (b.min.x <= max.x) &&
      (b.max.x >= min.x) &&
      (b.min.y <= max.y) &&
      (b.max.y >= min.y);
  }

  @override
  String toString() => 'Bounds($min, $max)';
}

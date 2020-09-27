import 'dart:math' as math;

import 'geometry.dart';

/// Rectangular bound delimited by orthogonal lines passing through two points.
class Bounds {

  final UPoint min;
  final UPoint max;
  
  // can accept Bounds(GeoPoint(20,30), GeoPoint(10, 10)) or 
  // Bounds([20, 30], [10, 10])
  factory Bounds(dynamic min, dynamic max) {
    Bounds bounds1 = Bounds._(UPoint.from(min), UPoint.from(max));
    Bounds bounds2 = bounds1.extend(min);
    return bounds2.extend(max);
  }
  
  const Bounds._(this.min, this.max);

  /// Creates a new [Bounds] obtained by expanding the current ones 
  /// with a new point.
  Bounds extend(dynamic _point) {
    UPoint point = UPoint.from(_point);
    UPoint _min;
    UPoint _max;

    if(min == null && max == null) {
      _min = point;
      _max = point;
    } else {
      double minX = math.min(point.x, min.x);
      double maxX = math.max(point.x, max.x);
      double minY = math.min(point.y, min.y);
      double maxY = math.max(point.y, max.y);

      _min = UPoint(minX, minY);
      _max = UPoint(maxX, maxY);
    }

    return Bounds._(_min, _max);
  }

  /// This [Bounds] central point.
  UPoint get center => UPoint(
    (min.x + max.x) / 2,
    (min.y + max.y) / 2,
  );

  /// Size of bounds.
  Size get size {
    return Size.from(max - min);
  }

  /// Bottom left corner's point.
  UPoint get bottomLeft => UPoint(min.x, max.y);

  /// Top right corner's point.
  UPoint get topRight => UPoint(max.x, min.y);

  /// Top left corner's point.
  UPoint get topLeft => min;

  /// Bottom right corner's point.
  UPoint get bottomRight => max;

  bool contains(UPoint point) {
    return containsBounds(Bounds(point, point));
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
  int get hashCode => min.hashCode ^ max.hashCode;
  
  @override
  bool operator ==(other) => other is Bounds && 
    min == other.min && max == other.max;

  @override
  String toString() => 'Bounds($min, $max)';

}
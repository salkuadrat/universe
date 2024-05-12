import 'dart:math';

import 'point.dart';

class Coordinate extends UPoint {
  final double z;

  Coordinate(num x, num y, [num z = 0])
      : z = z.toDouble(),
        super(x.toDouble(), y.toDouble());

  factory Coordinate.from(dynamic value) {
    assert(value is Coordinate ||
        value is UPoint ||
        (value is List<num> && (value.length == 2 || value.length == 3)));

    if (value is UPoint) {
      return Coordinate(value.x, value.y, 0);
    }

    if (value is List<num>) {
      if (value.length == 2) {
        final point = UPoint.from(value);
        return Coordinate(point.x, point.y, 0);
      }

      if (value.length == 3) {
        return Coordinate(
          value[0].toDouble(),
          value[1].toDouble(),
          value[2].toDouble(),
        );
      }
    }

    return value;
  }

  factory Coordinate.fromKey(String key) {
    final keys = key.split(':');

    if (keys.length >= 2) {
      double x = double.parse(keys[0]);
      double y = double.parse(keys[1]);
      double z = 0.0;

      if (keys.length > 2) {
        z = double.parse(keys[2]);
      }

      return Coordinate(x, y, z);
    }

    return Coordinate(0, 0, 0);
  }

  @override
  Coordinate operator +(Point other) {
    return Coordinate(x + other.x, y + other.y);
  }

  @override
  Coordinate operator -(Point other) {
    return Coordinate(x - other.x, y - other.y);
  }

  @override
  Coordinate operator *(num factor) {
    return Coordinate((x * factor), (y * factor));
  }

  @override
  Coordinate operator /(num factor) {
    if (factor == 0) throw Exception("Cannot divide by zero!");
    return Coordinate(x / factor, y / factor);
  }

  @override
  Coordinate ceil() {
    return Coordinate(x.ceilToDouble(), y.ceilToDouble(), z.ceilToDouble());
  }

  @override
  Coordinate floor() {
    return Coordinate(x.floorToDouble(), y.floorToDouble(), z.floorToDouble());
  }

  @override
  Coordinate round() {
    return Coordinate(x.roundToDouble(), y.roundToDouble(), z.roundToDouble());
  }

  @override
  Coordinate scaleBy(UPoint point) {
    Coordinate c = point is Coordinate ? point : Coordinate.from(point);
    return Coordinate(x * c.x, y * c.y, z * c.z);
  }

  @override
  Coordinate unscaleBy(UPoint point) {
    Coordinate c = point is Coordinate ? point : Coordinate.from(point);
    return Coordinate(
      (c.x == 0) ? 0 : (x / c.x),
      (c.y == 0) ? 0 : (y / c.y),
      (c.z == 0) ? 0 : (z / c.z),
    );
  }

  UPoint toPoint() => UPoint(x, y);

  String get key => '$x:$y:$z';

  @override
  int get hashCode => Object.hash(x.hashCode, y.hashCode, z.hashCode);

  @override
  bool operator ==(other) =>
      other is Coordinate && x == other.x && y == other.y && z == other.z;

  @override
  String toString() => 'Coordinate($x, $y, $z)';
}

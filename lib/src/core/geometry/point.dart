import 'dart:math';

class UPoint extends UniversalPoint<double> {
  
  const UPoint(double x, double y) : super(x, y);
  
  @override
  int get hashCode => x.hashCode ^ y.hashCode;
  
  @override
  bool operator ==(other) => other is UPoint && 
    x == other.x && y == other.y;

  factory UPoint.from(dynamic value) {
    if(value is UPoint) return value;

    final point = UniversalPoint.from(value);
    return UPoint(point.x.toDouble(), point.y.toDouble());
  }

  @override
  String toString() => 'UPoint($x, $y)';
}

class UniversalPoint<T extends num> extends Point<T> {
  final num z;

  const UniversalPoint(num x, num y, [this.z = 0]) : super(x, y);

  factory UniversalPoint.from(dynamic value) {
    if(value is UniversalPoint<T>) {
      return value;
    }

    if(value is List<T>) {
      if(value.length == 2) {
        return UniversalPoint(value[0], value[1]);
      }
      
      if(value.length == 3) {
        return UniversalPoint(value[0], value[1], value[2]);
      }
    }

    throw Exception("Invalid values!");
  }

  @override
  UniversalPoint<T> operator +(Point<T> other) {
    return UniversalPoint<T>(x + other.x, y + other.y, z + (other as UniversalPoint).z);
  }

  @override
  UniversalPoint<T> operator -(Point<T> other) {
    return UniversalPoint<T>(x - other.x, y - other.y, z - (other as UniversalPoint).z);
  }

  @override
  UniversalPoint<T> operator *(num factor) {
    return UniversalPoint<T>((x * factor), (y * factor), (z * factor));
  }

  UniversalPoint<T> operator /(num factor) {
    if(factor == 0) throw Exception("Cannot divide by zero!");
    return UniversalPoint<T>(x / factor, y / factor, z / factor);
  }

  UniversalPoint<T> ceil() {
    return UniversalPoint(x.ceil(), y.ceil(), z.ceil());
  }

  UniversalPoint<T> floor() {
    return UniversalPoint<T>(x.floor(), y.floor(), z.floor());
  }

  UniversalPoint round() {
    num x = this.x is double ? this.x.round() : this.x;
    num y = this.y is double ? this.y.round() : this.y;
    num z = this.z is double ? this.z.round() : this.z;
    return UniversalPoint(x, y, z);
  }

  UniversalPoint scaleBy(UniversalPoint point) {
    return UniversalPoint(x * point.x, y * point.y, z * point.z);
  }

  UniversalPoint<T> unscaleBy(UniversalPoint<T> point) {
    return UniversalPoint<T>(x / point.x, y / point.y, point.z == 0 ? 0 : z / point.z);
  }

  /* UniversalPoint multiplyBy(num n) {
    return UniversalPoint(x * n, y * n, z * n);
  } */

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
  
  @override
  bool operator ==(other) => other is UniversalPoint<T> && 
    x == other.x && y == other.y && z == other.z;

  @override
  String toString() => 'UniversalPoint($x, $y, $z)';
}
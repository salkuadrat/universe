import 'dart:math';
import 'dart:ui';

class UPoint extends Point<double> {
  
  const UPoint(double x, double y) : super(x, y);

  @override
  UPoint operator +(Point other) {
    return UPoint(x + other.x, y + other.y);
  }

  @override
  UPoint operator -(Point other) {
    return UPoint(x - other.x, y - other.y);
  }

  @override
  UPoint operator *(num factor) {
    return UPoint((x * factor), (y * factor));
  }

  UPoint operator /(num factor) {
    if(factor == 0) throw Exception("Cannot divide by zero!");
    return UPoint(x / factor, y / factor);
  }

  UPoint round() {
    double x = this.x.roundToDouble();
    double y = this.y.roundToDouble();
    return UPoint(x, y);
  }

  UPoint ceil() {
    return UPoint(x.ceilToDouble(), y.ceilToDouble());
  }

  UPoint floor() {
    return UPoint(x.floorToDouble(), y.floorToDouble());
  }

  UPoint scaleBy(UPoint point) {
    return UPoint(x * point.x, y * point.y);
  }

  UPoint unscaleBy(UPoint point) {
    return UPoint(
      (point.x == 0) ? 0 : (x / point.x), 
      (point.y == 0) ? 0 : (y / point.y),
    );
  }
  
  @override
  int get hashCode => hashValues(x.hashCode, y.hashCode);
  
  @override
  bool operator ==(other) => other is UPoint && 
    x == other.x && y == other.y;

  factory UPoint.from(dynamic value) {
    if(value is UPoint) {
      return UPoint(value.x, value.y);
    }

    if(value is List<num>) {
      if(value.length == 2) {
        return UPoint(value[0].toDouble(), value[1].toDouble());
      }
    }

    throw Exception("Invalid values!");
  }

  bool equal(other, [maxMargin=0.0001]) {
    UPoint o = UPoint.from(other);

    double margin = max(
      (this.x - o.x).abs(), 
      (this.y - o.y).abs(),
    );

    return margin <= maxMargin;
  }

  bool notEqual(other, [maxMargin=0.0001]) {
    return !equal(other, maxMargin);
  }

  @override
  String toString() => 'UPoint($x, $y)';
}
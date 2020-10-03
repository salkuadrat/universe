import 'dart:math';
import 'dart:ui';
import 'point.dart';

class Size extends UPoint {
  Size(double width, double height) : super(width, height);

  double get width => x;
  double get height => y;

  @override
  Size operator +(Point other) {
    return Size(x + other.x, y + other.y);
  }

  @override
  Size operator -(Point other) {
    return Size(x - other.x, y - other.y);
  }

  @override
  Size operator *(num factor) {
    return Size((x * factor), (y * factor));
  }

  @override
  Size operator /(num factor) {
    if(factor == 0) throw Exception("Cannot divide by zero!");
    return Size(x / factor, y / factor);
  }

  @override
  Size round() {
    double x = this.x.roundToDouble();
    double y = this.y.roundToDouble();
    return Size(x, y);
  }

  @override
  Size ceil() {
    return Size(x.ceilToDouble(), y.ceilToDouble());
  }

  @override
  Size floor() {
    return Size(x.floorToDouble(), y.floorToDouble());
  }

  @override
  Size scaleBy(UPoint point) {
    return Size(x * point.x, y * point.y);
  }

  @override
  Size unscaleBy(UPoint point) {
    return Size(
      (point.x == 0) ? 0 : (x / point.x), 
      (point.y == 0) ? 0 : (y / point.y),
    );
  }

  @override
  int get hashCode => hashValues(width.hashCode, height.hashCode);
  
  @override
  bool operator ==(other) => other is Size && 
    width == other.width && height == other.height;
  
  @override
  String toString() => 'Size($width, $height)';

  factory Size.from(dynamic value) {
    final size = UPoint.from(value);
    return Size(max(0, size.x.toDouble()), max(0, size.y.toDouble()));
  }
}
import 'dart:math' as Math;
import 'point.dart';

class Size extends UniversalPoint<double> {
  Size(double width, double height) : super(width, height);

  double get width => x;
  double get height => y;

  @override
  int get hashCode => width.hashCode ^ height.hashCode;
  
  @override
  bool operator ==(other) => other is Size && 
    width == other.width && height == other.height;
  
  @override
  String toString() => 'Size($width, $height)';

  factory Size.from(dynamic value) {
    final size = UniversalPoint.from(value);
    return Size(Math.max(0, size.x.toDouble()), Math.max(0, size.y.toDouble()));
  }
}
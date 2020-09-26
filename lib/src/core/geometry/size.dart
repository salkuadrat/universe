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
    if(value is Size) return Size(Math.max(0, value.width), Math.max(0, value.height));
    return (UniversalPoint<double>.from(value) as Size);
  }
}
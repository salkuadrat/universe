import 'package:universe/src/core/geometry/point.dart';

class Coordinates extends UniversalPoint<num> {

  const Coordinates(num x, num y, [num z = 0]) : super(x, y, z);

  String get key => '$x:$y:$z';

  factory Coordinates.from(dynamic value) {
    if(value is Coordinates) return value;
    return (UniversalPoint<num>.from(value) as Coordinates);
  }

  @override
  String toString() => 'Coordinates($x, $y, $z)';
  
}
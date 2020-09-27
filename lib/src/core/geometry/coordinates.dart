import 'package:universe/src/core/geometry/point.dart';

class Coordinates extends UniversalPoint<num> {

  const Coordinates(num x, num y, [num z = 0]) : super(x, y, z);

  String get key => '$x:$y:$z';

  factory Coordinates.from(dynamic value) {
    if(value is Coordinates) return value;

    final point = UniversalPoint.from(value);
    return Coordinates(point.x, point.y, point.z);
  }

  @override
  String toString() => 'Coordinates($x, $y, $z)';
  
}
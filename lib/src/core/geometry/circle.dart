import 'package:validate/validate.dart';

import '../latlng/distance/algorithm/vincenty.dart';
import '../latlng/distance/distance.dart';
import '../latlng/latlng.dart';

/// Circle-based GeoAlgorithms
/// 
/// By default, it uses Vincenty-Algorithm for distance calculation.
class GeoCircle {
  
  final LatLng center;
  final double radius;
  final DistanceAlgorithm algorithm;

  // can accept center => LatLng(20.0, 30.0) or center => [20.0, 30.0]
  GeoCircle(dynamic center, this.radius, {this.algorithm= const Vincenty()})
    : this.center = LatLng.from(center);

  /// Checks if a [point] is inside the given [Circle]
  /// 
  /// Circle circle = new Circle(new LatLng(0.0,0.0), 111319.0);
  /// LatLng newPos = new LatLng(1.0,0.0);
  /// 
  /// expect(circle.isPointInside(newPos),isTrue);
  /// 
  /// Circle circle2 = new Circle(new LatLng(0.0,0.0), 111318.0);
  /// 
  /// expect(circle2.isPointInside(newPos),isFalse);
  /// 
  bool isPointInside(LatLng point) {
    Validate.notNull(point);
    Distance distance = new Distance(algorithm: algorithm);
    return distance(center, point) <= radius;
  }
}
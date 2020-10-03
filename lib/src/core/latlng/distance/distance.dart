import 'dart:math' as math;

import 'package:validate/validate.dart';

import '../../../shared.dart';
import '../../core.dart';

abstract class DistanceAlgorithm {
  double distance(dynamic position, dynamic destination);
  LatLng offset(dynamic from, double distanceInMeter, double bearing);
}

class Distance implements DistanceAlgorithm {

  final DistanceAlgorithm algorithm;
  final double radius;
  final bool isRound;

  const Distance({
    this.algorithm = const Haversine(),  
    this.isRound = true,
  }) : radius = EARTH_RADIUS;

  Distance.withRadius(this.radius, {this.algorithm = const Haversine(), this.isRound=true}) {
    Validate.isTrue(radius > 0, "Radius must be greater than 0");
  }

  /// Shortcut for [distance]
  num call(dynamic position, dynamic destination) {
    return distance(position, destination);
  }

  /// Computes the distance between two points.
  @override
  double distance(dynamic position, dynamic destination, {LengthUnit unit=LengthUnit.M}) {
    position = LatLng.from(position);
    destination = LatLng.from(destination);
    double distance = algorithm.distance(position, destination);
    return _round(LengthUnit.M.to(unit, distance));
  }

  /// Returns a destination point based on the given [distance] and [bearing]
  ///
  /// Given a [from] (start) point, initial [bearing], and [distance],
  /// this will calculate the destination point and
  /// final bearing travelling along a (shortest distance) great circle arc.
  ///
  ///     final Distance distance = const Distance();
  ///
  ///     final num distanceInMeter = (EARTH_RADIUS * math.PI / 4).round();
  ///
  ///     final p1 = new LatLng(0.0, 0.0);
  ///     final p2 = distance.offset(p1, distanceInMeter, 180);
  ///
  /// Bearing: Left - 270°, right - 90°, up - 0°, down - 180°
  @override
  LatLng offset(dynamic from, double distanceInMeter, double bearing) 
    => algorithm.offset(LatLng.from(from), distanceInMeter, bearing);

  /// Returns the great circle bearing (direction) in degrees to the next point ([p2])
  ///
  /// Find out about the difference between rhumb line and
  /// great circle bearing on [Wikipedia](http://en.wikipedia.org/wiki/Rhumb_line#General_and_mathematical_description).
  ///
  /// Distance distance = Distance();
  ///
  /// LatLng position = new LatLng(0.0, 0.0);
  /// LatLng destination = new LatLng(-90.0, 0.0);
  ///
  /// expect(distance.bearing(position, destination), equals(180));
  double bearing(dynamic position, dynamic destination) {
    position = LatLng.from(position);
    destination = LatLng.from(destination);
    
    final longDiff = destination.longitudeInRad - position.longitudeInRad;
    
    final y = math.sin(longDiff);
    final x = 
      (math.cos(position.latitudeInRad) * math.tan(destination.latitudeInRad)) - 
      (math.sin(position.latitudeInRad) * math.cos(longDiff));
    
    return radianToDeg(math.atan2(y, x));
  }

  double _round(double value) => isRound ? value.round().toDouble() : value;
}

/// Shortcut for:
/// Distance distance = Distance(algorithm: Vincenty());
///
class DistanceVincenty extends Distance {
  DistanceVincenty({bool isRound=true}): 
    super(isRound: isRound, algorithm: Vincenty());

  DistanceVincenty.withRadius(double radius, {bool isRound=true}): 
    super.withRadius(radius, isRound: isRound, algorithm: Vincenty());
}

/// Shortcut for:
/// Distance distance = Distance(algorithm: Haversine());
///
class DistanceHaversine extends Distance {
  DistanceHaversine({bool isRound=true}): 
    super(isRound: isRound, algorithm: Haversine());

  DistanceHaversine.withRadius(double radius, {bool isRound=true}): 
    super.withRadius(radius, isRound: isRound, algorithm: Haversine());
}
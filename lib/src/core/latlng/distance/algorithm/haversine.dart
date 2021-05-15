import 'dart:math' as math;

import '../../../../validate/validate.dart';
import '../../../../shared.dart';
import '../../../core.dart';

class Haversine implements DistanceAlgorithm {
  const Haversine();

  /// Calculates distance with Haversine algorithm.
  ///
  /// Accuracy can be out by 0.3%
  /// More on [Wikipedia](https://en.wikipedia.org/wiki/Haversine_formula)
  @override
  double distance(dynamic position, dynamic destination) {
    position = LatLng.from(position);
    destination = LatLng.from(destination);

    final sinLatDist = math.sin((destination.latitudeInRad - position.latitudeInRad) / 2);
    final sinLngDist = math.sin((destination.longitudeInRad - position.longitudeInRad) / 2);
    
    // Sides
    final a = 
      (sinLatDist * sinLatDist) + 
      (sinLngDist * sinLngDist) * math.cos(position.latitudeInRad) * math.cos(destination.latitudeInRad);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    
    return EQUATOR_RADIUS * c;
  }

  /// Returns a destination point based on the given [distance] and [bearing]
  ///
  /// Given a [from] (start) point, initial [bearing], and [distance],
  /// this will calculate the destination point and
  /// bearing travelling along a (shortest distance) great circle arc.
  ///
  /// Haversine distance = Haversine();
  /// double distanceInMeter = EARTH_RADIUS * math.PI / 4;
  ///
  /// LatLng position = LatLng(0.0, 0.0);
  /// LatLng destination = distance.offset(position, distanceInMeter, 180);
  ///
  @override
  LatLng offset(dynamic from, double? distanceInMeter, double bearing) {
    from = LatLng.from(from);
    
    Validate.inclusiveBetween(-180.0, 180.0, bearing, 
      "Bearing angle must be between -180 and 180 degrees");
    
    double h = degToRadian(bearing);
    double a = distanceInMeter! / EQUATOR_RADIUS;
    double latitude = math.asin(
      math.sin(from.latitudeInRad) * math.cos(a) + 
      math.cos(from.latitudeInRad) * math.sin(a) * math.cos(h) 
    );

    double longitude = from.longitudeInRad + 
      math.atan2(
        math.sin(h) * math.sin(a) * math.cos(from.latitudeInRad), 
        math.cos(a) - math.sin(from.latitudeInRad) * math.sin(latitude),
      );
    
    return LatLng(radianToDeg(latitude), radianToDeg(longitude));
  }
}
import 'dart:math';

import 'package:validate/validate.dart';

import '../../../../shared.dart';
import '../../latlng.dart';
import '../distance.dart';

class Haversine implements DistanceAlgorithm {
  const Haversine();

  /// Calculates distance with Haversine algorithm.
  ///
  /// Accuracy can be out by 0.3%
  /// More on [Wikipedia](https://en.wikipedia.org/wiki/Haversine_formula)
  @override
  double distance(LatLng position, LatLng destination) {
    final sinLatDist = sin((destination.latitudeInRad - position.latitudeInRad) / 2);
    final sinLngDist = sin((destination.longitudeInRad - position.longitudeInRad) / 2);
    
    // Sides
    final a = (sinLatDist * sinLatDist) + (sinLngDist * sinLngDist) * cos(position.latitudeInRad) * cos(destination.latitudeInRad);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
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
  LatLng offset(LatLng from, double distanceInMeter, double bearing) {
    
    Validate.inclusiveBetween(-180.0, 180.0, bearing, 
      "Bearing angle must be between -180 and 180 degrees");
    
    double h = degToRadian(bearing);
    double a = distanceInMeter / EQUATOR_RADIUS;
    double latitude = asin( sin(from.latitudeInRad) * cos(a) + cos(from.latitudeInRad) * sin(a) * cos(h) );
    double longitude = from.longitudeInRad + 
      atan2(
        sin(h) * sin(a) * cos(from.latitudeInRad), 
        cos(a) - sin(from.latitudeInRad) * sin(latitude),
      );
    
    return LatLng(radianToDeg(latitude), radianToDeg(longitude));
  }
}
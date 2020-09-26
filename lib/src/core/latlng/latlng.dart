import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:universe/src/core/geometry/point.dart';
import 'package:universe/src/shared.dart' as s;

/// Geographic coordinates in degrees.
/// 
/// LatLng latlng = LatLng(51.519475, -19.37555556); or with altitude
/// LatLng latlng = LatLng(51.519475, -19.37555556, 20.0); 
class LatLng extends UniversalPoint<double> {

  double latitude;
  double longitude;
  double altitude;

  double get lat => latitude;
  double get lng => longitude;
  double get alt => altitude;

  LatLng(this.latitude, this.longitude, [this.altitude=0]) 
    : super(latitude, longitude, altitude);

  factory LatLng.from(dynamic value) {
    if(value is LatLng) {
      return value;
    }
    
    if(value is List<num>) {
      if(value.length == 3) 
        return LatLng(
          value[0].toDouble(), 
          value[1].toDouble(), 
          value[2].toDouble(),
        );
      
      if(value.length == 2) 
        return LatLng(
          value[0].toDouble(), 
          value[1].toDouble(),
        );
    }

    throw Exception("Invalid values!");
  }

  double get latitudeInRad => s.degToRadian(latitude);

  double get longitudeInRad => s.degToRadian(longitude);

  LatLng round({int decimals = 6}) => LatLng(
    s.round(lat, decimals: decimals),
    s.round(lng, decimals: decimals),
    s.round(alt, decimals: decimals),
  );

  NumberFormat get formatter => NumberFormat('0.0#####');
  String get latitudeStr => formatter.format(lat);
  String get longitudeStr => formatter.format(lng);
  String get altitudeStr => formatter.format(alt);

  /// Returns `true` if the given position is at the same position 
  /// (within a small margin of error). 
  /// 
  /// The margin of error can be overridden by setting `maxMargin` to a small number.
  /// 
  /// can accept other: GeoPosition(20.0, 30.0) or other: [20.0, 30.0]
  bool equal(other, {maxMargin=1.0E-9}) {
    LatLng o = LatLng.from(other);

    double margin = math.max(
      (this.lat - o.lat).abs(), 
      (this.lng - o.lng).abs(),
    );

    return margin <= maxMargin;
  }

  @override
  String toString() => 
    'LatLng (Latitude:$latitudeStr, Longitude:$longitudeStr, Altitude:$altitudeStr)';
  
  @override
  int get hashCode => lat.hashCode ^ lng.hashCode ^ alt.hashCode;
  
  @override
  bool operator ==(other) => other is LatLng && 
    lat == other.lat && lng == other.lng && alt == other.alt;
  
  /// Converts lat/long values into sexagesimal
  ///
  /// LatLng location = LatLng(51.519475, -19.37555556);
  /// print(location.toSexagesimal());
  ///     
  /// Result: 51° 31' 10.11" N, 19° 22' 32.00" W
  String toSexagesimal() {
    String latDirection = lat >= 0 ? "N" : "S";
    String longDirection = lng >= 0 ? "O" : "W";
    String latSexagesimal = s.decimal2sexagesimal(lat);
    String longSexagesimal = s.decimal2sexagesimal(lng);

    return "$latSexagesimal $latDirection, $longSexagesimal $longDirection";
  }
}
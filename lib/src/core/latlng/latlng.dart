import 'dart:math' as math;
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:universe/src/shared.dart' as s;

import '../core.dart';

export 'latlng.dart';
export 'latlng_bounds.dart';
export 'path.dart';
export 'safe_bounds.dart';
export 'distance/algorithm/haversine.dart';
export 'distance/algorithm/vincenty.dart';
export 'distance/distance.dart';
export 'spline/catmullrom.dart';
export 'unit/length.dart';

/// Geographic coordinates in degrees.
///
/// LatLng latlng = LatLng(51.519475, -19.37555556); or with altitude
/// LatLng latlng = LatLng(51.519475, -19.37555556, 20.0);
class LatLng extends Coordinate {
  double _latitude;
  double _longitude;
  double _altitude;

  double get lat => _latitude;
  double get lng => _longitude;
  double get alt => _altitude;

  LatLng(latitude, longitude, [altitude = 0.0])
      : _latitude = latitude?.toDouble() ?? 0.0,
        _longitude = longitude?.toDouble() ?? 0.0,
        _altitude = altitude?.toDouble() ?? 0.0,
        super(
          latitude?.toDouble() ?? 0.0,
          longitude?.toDouble() ?? 0.0,
          altitude?.toDouble() ?? 0.0,
        );

  factory LatLng.from(dynamic value) {
    assert(value is LatLng ||
        (value is List &&
            value.isNotEmpty &&
            (value.first is int || value.first is double) &&
            (value.length == 2 || value.length == 3)));

    if (value is List &&
        value.isNotEmpty &&
        (value.first is int || value.first is double)) {
      if (value.length == 3)
        return LatLng(
          value[0].toDouble(),
          value[1].toDouble(),
          value[2].toDouble(),
        );

      if (value.length == 2)
        return LatLng(
          value[0].toDouble(),
          value[1].toDouble(),
        );
    }

    return value;
  }

  double get latitudeInRad => s.degToRadian(_latitude);

  double get longitudeInRad => s.degToRadian(_longitude);

  LatLng round({int decimals = 6}) => LatLng(
        s.round(_latitude, decimals: decimals),
        s.round(_longitude, decimals: decimals),
        s.round(_altitude, decimals: decimals),
      );

  NumberFormat get formatter => NumberFormat('0.0#####');
  String get latitudeStr => formatter.format(_latitude);
  String get longitudeStr => formatter.format(_longitude);
  String get altitudeStr => formatter.format(_altitude);

  /// Returns `true` if the given position is at the same position
  /// (within a small margin of error).
  ///
  /// The margin of error can be overridden by setting `maxMargin` to a small number.
  ///
  /// can accept other: LatLng(20.0, 30.0) or other: [20.0, 30.0]
  bool equal(other, [maxMargin = 0.0001]) {
    if (other == null) {
      return false;
    }

    LatLng o = LatLng.from(other);

    double margin = math.max(
      (this.lat - o.lat).abs(),
      (this.lng - o.lng).abs(),
    );

    margin = math.max(margin, (this.alt - o.alt).abs());

    return margin <= maxMargin;
  }

  bool notEqual(other, [maxMargin = 0.0001]) {
    return !equal(other, maxMargin);
  }

  @override
  String toString() => 'LatLng($latitudeStr, $longitudeStr, $altitudeStr)';

  String toSimpleString() => '$latitudeStr, $longitudeStr';

  @override
  int get hashCode => hashValues(
      latitudeStr.hashCode, longitudeStr.hashCode, altitudeStr.hashCode);

  @override
  bool operator ==(other) =>
      other is LatLng &&
      lat == other.lat &&
      lng == other.lng &&
      alt == other.alt;

  /// Converts lat/long values into sexagesimal
  ///
  /// LatLng location = LatLng(51.519475, -19.37555556);
  /// print(location.toSexagesimal());
  ///
  /// Result: 51° 31' 10.11" N, 19° 22' 32.00" W
  String toSexagesimal() {
    String latDirection = _latitude >= 0 ? "N" : "S";
    String longDirection = _longitude >= 0 ? "O" : "W";
    String latSexagesimal = s.decimal2sexagesimal(_latitude);
    String longSexagesimal = s.decimal2sexagesimal(_longitude);

    return "$latSexagesimal $latDirection, $longSexagesimal $longDirection";
  }
}

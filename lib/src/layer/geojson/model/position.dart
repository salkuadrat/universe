import '../../../core/core.dart';

class Position {
  final List<double> _coordinates;

  Position(num latitude, num longitude, [num altitude = 0.0])
      : _coordinates = [
          latitude.toDouble(),
          longitude.toDouble(),
          altitude.toDouble(),
        ];

  Position.from(List<num> coordinates)
      : _coordinates = [
          coordinates[0].toDouble(),
          coordinates[1].toDouble(),
          if (coordinates.length == 3) coordinates[2].toDouble(),
        ];

  List<double> get coordinates => _coordinates;

  LatLng get latlng => LatLng(latitude, longitude, altitude);

  double get latitude => _coordinates[0];

  set latitude(num latitude) {
    _coordinates[0] = latitude.toDouble();
  }

  double get longitude => _coordinates[1];

  set longitude(num longitude) {
    _coordinates[1] = longitude.toDouble();
  }

  double get altitude => _coordinates[2];

  set altitude(num altitude) {
    _coordinates[2] = altitude.toDouble();
  }

  @override
  String toString() => '[$latitude, $longitude, $altitude]';
}

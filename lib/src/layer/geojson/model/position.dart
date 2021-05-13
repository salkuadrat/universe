import '../../../core/core.dart';

class Position {

  List<double> _coordinates = [0.0, 0.0, 0.0];

  Position(num latitude, num longitude, [num altitude = 0.0]) 
    : this._coordinates = [ 
        latitude.toDouble(), 
        longitude.toDouble(), 
        altitude.toDouble(),
      ];

  Position.from(List<num> coordinates) 
    : this._coordinates = [ 
        coordinates[0].toDouble(),
        coordinates[1].toDouble(),
        if(coordinates.length == 3) coordinates[2].toDouble(),
      ];
    
  List<double> get coordinates => _coordinates;

  LatLng get latlng => LatLng(latitude, longitude, altitude);

  double get latitude => _coordinates[0];
  
  set latitude(num latitude) {
    this._coordinates[0] = latitude.toDouble();
  }

  double get longitude => _coordinates[1];

  set longitude(num longitude) {
    this._coordinates[1] = longitude.toDouble();
  }

  double get altitude => _coordinates[2];

  set altitude(num altitude) {
    this._coordinates[2] = altitude.toDouble();
  }

  @override
  String toString() => '[$latitude, $longitude, $altitude]';

}
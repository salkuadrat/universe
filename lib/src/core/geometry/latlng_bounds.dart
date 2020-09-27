import 'dart:math';

import '../../shared.dart';
import '../latlng/latlng.dart';

class LatLngBounds {

  LatLng _sw;
  LatLng _ne;

  // can accept LatLngBounds([LatLng(20,30), LatLng(10, 10)]) or 
  // LatLngBounds([[20, 30], [10, 10]])
  LatLngBounds([dynamic southWest, dynamic northEast]) {
    extend(southWest);
    extend(northEast);
  }

  // can accept parameter as [LatLng(20,30), LatLng(10, 10), ...] or 
  // [[20, 30], [10, 10], ...]
  LatLngBounds.from(List<dynamic> positions) {
    if(positions != null && positions.isNotEmpty) {

      num minX;
      num maxX;
      num minY;
      num maxY;

      for(var position in positions) {
        LatLng pos = LatLng.from(position);
        double x = pos.longitudeInRad;
        double y = pos.latitudeInRad;

        if(minX == null || minX > x) {
          minX = x;
        }

        if(minY == null || minY > y) {
          minY = y;
        }

        if(maxX == null || maxX < x) {
          maxX = x;
        }

        if(maxY == null || maxY < y) {
          maxY = y;
        }
      }

      _sw = LatLng(radianToDeg(minY), radianToDeg(minX));
      _ne = LatLng(radianToDeg(maxY), radianToDeg(maxX));
    }
  }

  extend(dynamic _position) {
    LatLng position = LatLng.from(_position);

    if(position != null) {
      _extend(position, position);
    }
  }

  extendBounds(LatLngBounds bounds) {
    _extend(bounds.southWest, bounds.northEast);
  }

  _extend(LatLng sw, LatLng ne) {
    if (_sw == null && _ne == null) {
      _sw = LatLng(sw.latitude, sw.longitude);
      _ne = LatLng(ne.latitude, ne.longitude);
    } else {
      _sw.latitude = min(sw.latitude, _sw.latitude);
      _sw.longitude = min(sw.longitude, _sw.longitude);
      _ne.latitude = max(ne.latitude, _ne.latitude);
      _ne.longitude = max(ne.longitude, _ne.longitude);
    }
  }

  double get west => southWest.longitude;
  double get south => southWest.latitude;
  double get east => northEast.longitude;
  double get north => northEast.latitude;

  LatLng get southWest => _sw;
  LatLng get northEast => _ne;
  LatLng get northWest => LatLng(north, west);
  LatLng get southEast => LatLng(south, east);

  LatLng get center => LatLng(
    (south + north) / 2, 
    (west + east) / 2,
  );

  bool get isValid => southWest != null && northEast != null;
  bool get isNotValid => !isValid;

  bool contains(LatLng point) {
    if(isValid) {
      return containsBounds(LatLngBounds(point, point));
    }

    return false;
  }

  bool containsBounds(LatLngBounds bounds) {
    var sw = bounds._sw;
    var ne = bounds._ne;

    return (sw.latitude >= _sw.latitude) &&
        (ne.latitude <= _ne.latitude) &&
        (sw.longitude >= _sw.longitude) &&
        (ne.longitude <= _ne.longitude);
  }

  bool isOverlapping(LatLngBounds bounds) {
    if (!isValid) {
      return false;
    }

    // check if bounding box rectangle is outside the other, 
    // if it is then it's considered not overlapping
    if (_sw.latitude > bounds._ne.latitude ||
        _ne.latitude < bounds._sw.latitude ||
        _ne.longitude < bounds._sw.longitude ||
        _sw.longitude > bounds._ne.longitude) {
      return false;
    }

    return true;
  }  
}
import 'dart:math';
import 'dart:ui';

import 'latlng.dart';

class LatLngBounds {

  LatLng _sw;
  LatLng _ne;

  // can accept LatLngBounds([LatLng(20,30), LatLng(10, 10)]) or 
  // LatLngBounds([[20, 30], [10, 10]])
  LatLngBounds(dynamic southWest, [dynamic northEast]) {
    if(northEast != null) {
      extend(southWest);
      extend(northEast);
    } else if(southWest is List && southWest.length > 1) {
      for(dynamic corner in southWest) {
        extend(LatLng.from(corner));
      }
    }
  }

  // can accept parameter as [LatLng(20,30), LatLng(10, 10), ...] or 
  // [[20, 30], [10, 10], ...]
  factory LatLngBounds.from(dynamic latlngs) {
    if(latlngs is LatLngBounds) return latlngs;

    if(latlngs is List && latlngs.length > 1) {
      return LatLngBounds(latlngs);
    }

    throw Exception("Invalid values!");
  }
  
  extend(dynamic _latlng) {
    LatLng latlng = LatLng.from(_latlng);

    if(latlng != null) {
      _extend(latlng, latlng);
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

  bool contains(LatLng latlng) {
    if(isValid) {
      return containsBounds(LatLngBounds(latlng, latlng));
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

  bool isOverlaps(LatLngBounds bounds) {
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

  bool isNotOverlaps(LatLngBounds bounds) => !isOverlaps(bounds);

  @override
  int get hashCode => hashValues(southWest.hashCode, northEast.hashCode);
  
  @override
  bool operator ==(other) => other is LatLngBounds && 
    southWest == other.southWest && northEast == other.northEast;

  @override
  String toString() => 'LatLngBounds($southWest, $northEast)';

}
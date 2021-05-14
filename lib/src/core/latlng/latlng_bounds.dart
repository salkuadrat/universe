import 'dart:math';
import 'dart:ui';

import 'latlng.dart';

class LatLngBounds {

  LatLng? _sw;
  LatLng? _ne;

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
    assert(
      latlngs is LatLngBounds || 
      (latlngs is List && latlngs.length > 1)
    );

    if(latlngs is List && latlngs.length > 1) {
      return LatLngBounds(latlngs);
    }
    
    return latlngs;
  }
  
  extend(dynamic _latlng) {
    LatLng latlng = LatLng.from(_latlng);
    
    _extend(latlng, latlng);
  }

  extendBounds(LatLngBounds bounds) {
    if(bounds.southWest != null && bounds.northEast != null) {
      _extend(bounds.southWest!, bounds.northEast!);
    }
  }

  _extend(LatLng sw, LatLng ne) {
    if (_sw == null && _ne == null) {
      _sw = LatLng(sw.lat, sw.lng);
      _ne = LatLng(ne.lat, ne.lng);
    } else {
      _sw = LatLng(
        min(sw.lat, _sw!.lat), 
        min(sw.lng, _sw!.lng));
      
      _ne = LatLng(
        max(ne.lat, _ne!.lat), 
        max(ne.lng, _ne!.lng));
    }
  }

  double? get west => southWest!.lng;
  double? get south => southWest!.lat;
  double? get east => northEast!.lng;
  double? get north => northEast!.lat;

  LatLng? get southWest => _sw;
  LatLng? get northEast => _ne;
  LatLng get northWest => LatLng(north, west);
  LatLng get southEast => LatLng(south, east);

  LatLng get center => LatLng(
    (south! + north!) / 2, 
    (west! + east!) / 2,
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
    var sw = bounds._sw!;
    var ne = bounds._ne;

    return (sw.lat >= _sw!.lat) &&
        (ne!.lat <= _ne!.lat) &&
        (sw.lng >= _sw!.lng) &&
        (ne.lng <= _ne!.lng);
  }

  bool isOverlaps(LatLngBounds bounds) {
    if (!isValid) {
      return false;
    }

    // check if bounding box rectangle is outside the other, 
    // if it is then it's considered not overlapping
    if (_sw!.lat > bounds._ne!.lat ||
        _ne!.lat < bounds._sw!.lat ||
        _ne!.lng < bounds._sw!.lng ||
        _sw!.lng > bounds._ne!.lng) {
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
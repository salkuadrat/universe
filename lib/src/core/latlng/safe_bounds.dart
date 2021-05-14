import 'latlng.dart';

class SafeBounds {
  final LatLngBounds bounds;
  final bool isLatOutOfBounds;
  final bool isLngOutOfBounds;

  SafeBounds(LatLng southWest, LatLng northEast) : 
    bounds = LatLngBounds(southWest, northEast), 
    isLatOutOfBounds = southWest.lat > northEast.lat, 
    isLngOutOfBounds = southWest.lng > northEast.lng;

  bool contains(LatLng latlng) {
    return (isLatOutOfBounds || isLngOutOfBounds) ? false : bounds.contains(latlng);
  }

  LatLng containLatLng(LatLng latlng, LatLng fallback) {
    if(isLatOutOfBounds || isLngOutOfBounds) 
      return fallback;
    
    final latitude = latlng.lat.clamp(bounds.south!, bounds.north!);
    final longitude = latlng.lng.clamp(bounds.west!, bounds.east!);
    return LatLng(latitude, longitude);
  }
}
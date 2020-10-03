import 'latlng.dart';

class SafeBounds {
  final LatLngBounds bounds;
  final bool isLatOutOfBounds;
  final bool isLngOutOfBounds;

  SafeBounds(LatLng southWest, LatLng northEast) : 
    bounds = LatLngBounds(southWest, northEast), 
    isLatOutOfBounds = southWest.latitude > northEast.latitude, 
    isLngOutOfBounds = southWest.longitude > northEast.longitude;

  bool contains(LatLng latlng) {
    return (isLatOutOfBounds || isLngOutOfBounds) ? false : bounds.contains(latlng);
  }

  LatLng containLatLng(LatLng latlng, LatLng fallback) {
    final lat = isLatOutOfBounds 
      ? fallback.lat 
      : latlng.lat.clamp(bounds.south, bounds.north);
    
    final lng = isLngOutOfBounds 
      ? fallback.lng 
      : latlng.lng.clamp(bounds.west, bounds.east);
    
    return LatLng(lat, lng);
  }
}
import 'latlng.dart';

class SafeBounds {
  final LatLngBounds bounds;
  final bool isLatOutOfBounds;
  final bool isLngOutOfBounds;

  SafeBounds(LatLng southWest, LatLng northEast) : 
    bounds = LatLngBounds(southWest, northEast), 
    isLatOutOfBounds = southWest.latitude! > northEast.latitude!, 
    isLngOutOfBounds = southWest.longitude! > northEast.longitude!;

  bool contains(LatLng latlng) {
    return (isLatOutOfBounds || isLngOutOfBounds) ? false : bounds.contains(latlng);
  }

  LatLng containLatLng(LatLng? latlng, LatLng? fallback) {
    final num? latitude = isLatOutOfBounds 
      ? fallback!.latitude 
      : latlng!.latitude!.clamp(bounds.south!, bounds.north!);
    
    final num? longitude = isLngOutOfBounds 
      ? fallback!.longitude 
      : latlng!.longitude!.clamp(bounds.west!, bounds.east!);
    
    return LatLng(latitude, longitude);
  }
}
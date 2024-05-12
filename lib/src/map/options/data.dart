import '../../core/core.dart';

/// Object to be used for streaming map data
class MapData {
  /// LatLng center of this map data
  final LatLng center;

  /// Zoom level of this map data
  final double zoom;

  // center can use format LatLng(20.0, 30.0) or [20.0, 30.0]
  MapData({dynamic center, required this.zoom}) : center = LatLng.from(center);
}

import '../../core/core.dart';

class MapData {
  final LatLng center;
  final double zoom;
  
  // can accept center: LatLng(20.0, 30.0) or center: [20.0, 30.0]
  MapData({dynamic center, this.zoom}) :
    this.center = LatLng.from(center);
}
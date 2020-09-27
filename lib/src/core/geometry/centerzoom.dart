import '../latlng/latlng.dart';

class CenterZoom {
  LatLng center;
  final double zoom;

  // can accept center: LatLng(20.0, 30.0) or center: [20.0, 30.0]
  CenterZoom({dynamic center, this.zoom}) {
    this.center = LatLng.from(center);
  }
}
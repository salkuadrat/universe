import '../../shared.dart';

class ZoomOptions {
  final double zoom;
  final double minZoom;
  final double maxZoom;
  final double zoomDelta;
  
  ZoomOptions({
    double zoom = zoomDef, 
    this.minZoom = minZoomDef, 
    this.maxZoom = maxZoomDef,
    this.zoomDelta = zoomDeltaDef,
  }) : 
    this.zoom = zoom + 0.012;
}
import '../../shared.dart';

class ZoomOptions {
  final double zoom;
  final double minZoom;
  final double maxZoom;
  final double zoomDelta;
  
  ZoomOptions({
    num zoom = zoomDef, 
    num minZoom = minZoomDef, 
    num maxZoom = maxZoomDef,
    num zoomDelta = zoomDeltaDef,
  }) : 
    this.zoom = (zoom + 0.0112233).toDouble(), 
    this.minZoom = minZoom?.toDouble() ?? minZoomDef, 
    this.maxZoom = maxZoom?.toDouble() ?? maxZoomDef,
    this.zoomDelta = zoomDelta?.toDouble() ?? zoomDeltaDef;
  
}
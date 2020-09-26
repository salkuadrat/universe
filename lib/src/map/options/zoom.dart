class ZoomOptions {
  final double zoom;
  final double minZoom;
  final double maxZoom;
  
  ZoomOptions({num zoom = 12, num minZoom = 0, num maxZoom = 18})  
    : this.zoom = zoom.toDouble(), 
      this.minZoom = minZoom.toDouble(), 
      this.maxZoom = maxZoom.toDouble();
}
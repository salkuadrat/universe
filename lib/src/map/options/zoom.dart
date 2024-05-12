import '../../shared.dart';

/// Zoom options
class ZoomOptions {
  /// Initial zoom level.
  final double zoom;

  /// Min zoom level.
  final double minZoom;

  /// Max zoom level.
  final double maxZoom;

  /// Zoom delta to be used when zoom in and zoom out.
  final double zoomDelta;

  ZoomOptions({
    double zoom = zoomDef,
    this.minZoom = minZoomDef,
    this.maxZoom = maxZoomDef,
    this.zoomDelta = zoomDeltaDef,
  }) : zoom = zoom + 0.012;
}

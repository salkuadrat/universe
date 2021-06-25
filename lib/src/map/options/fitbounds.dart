import 'package:flutter/rendering.dart';

import '../../shared.dart';

/// Fit bounds options
class FitBoundsOptions {
  /// Fit bounds padding
  /// Default: EdgeInsets.all(12.0)
  final EdgeInsets padding;

  /// Fit bounds maximum zoom value
  final double maxZoom;

  /// Fit bounds initial zoom value
  final double zoom;

  const FitBoundsOptions({
    this.padding = const EdgeInsets.all(12.0),
    this.maxZoom = maxZoomDef,
    this.zoom = zoomDef,
  });
}

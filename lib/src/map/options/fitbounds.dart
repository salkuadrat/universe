import 'package:flutter/rendering.dart';

import '../../shared.dart';

class FitBoundsOptions {

  final EdgeInsets padding;
  final double maxZoom;
  final double zoom;

  const FitBoundsOptions({
    this.padding = const EdgeInsets.all(12.0),
    this.maxZoom = maxZoomDef,
    this.zoom = zoomDef,
  });
}
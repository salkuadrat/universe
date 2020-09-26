import 'package:flutter/rendering.dart';

class FitBoundsOptions {
  final EdgeInsets padding;
  final double maxZoom;
  final double zoom;

  bool get hasMaxZoom => maxZoom != null;

  const FitBoundsOptions({
    this.padding = const EdgeInsets.all(0.0),
    this.maxZoom,
    this.zoom,
  });
}
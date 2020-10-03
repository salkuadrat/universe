import 'package:flutter/widgets.dart';

import '../../shared.dart';
import '../layer.dart';
import 'image.dart';

class MarkerLayerOptions extends LayerOptions {
  
  final double size;
  final double width;
  final double height;
  final MarkerAlignment align;
  final Color color;
  final MarkerIcon icon;
  final MarkerImage image;
  final Widget widget;
  final Offset offset;
  final double opacity;

  MarkerLayerOptions({
    num size,
    num width,
    num height,
    this.opacity = opacityDef,
    this.icon = markerIconDef, 
    this.image,
    this.widget, 
    this.color,
    this.offset,
    this.align = MarkerAlignment.top,
    bool interactive = interactiveDef,
  }) : 
    this.size = size?.toDouble(),
    this.width = width?.toDouble() ?? size?.toDouble(),
    this.height = height?.toDouble() ?? size?.toDouble(),
    super(interactive: interactive);
}
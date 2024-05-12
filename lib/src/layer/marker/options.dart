import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../shared.dart';
import '../layer.dart';

class MarkerLayerOptions extends InteractiveLayerOptions {
  final double? size;
  final double? width;
  final double? height;
  final MarkerAlignment align;
  final Color? color;
  final MarkerIcon? icon;
  final MarkerImage? image;
  final MarkerSvg? svg;
  final Widget? widget;
  final MarkerOffset? offset;
  final double opacity;

  MarkerLayerOptions({
    num? size = markerSizeDef,
    num? width = markerSizeDef,
    num? height = markerSizeDef,
    this.opacity = opacityDef,
    dynamic widget = markerDef,
    this.color,
    this.offset,
    this.align = MarkerAlignment.top,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
    TapLayerCallback? onTap,
    TapUpLayerCallback? onTapUp,
    TapDownLayerCallback? onTapDown,
    TapLayerCallback? onTapCancel,
    TapLayerCallback? onSecondaryTap,
    TapDownLayerCallback? onSecondaryTapDown,
    TapUpLayerCallback? onSecondaryTapUp,
    TapLayerCallback? onSecondaryTapCancel,
    DoubleTapLayerCallback? onDoubleTap,
    LongPressLayerCallback? onLongPress,
    LongPressStartLayerCallback? onLongPressStart,
    LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate,
    LongPressUpLayerCallback? onLongPressUp,
    LongPressEndLayerCallback? onLongPressEnd,
    LongPressLayerCallback? onSecondaryLongPress,
    LongPressStartLayerCallback? onSecondaryLongPressStart,
    LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate,
    LongPressUpLayerCallback? onSecondaryLongPressUp,
    LongPressEndLayerCallback? onSecondaryLongPressEnd,
  })  : size = size?.toDouble(),
        width = width?.toDouble() ?? size?.toDouble(),
        height = height?.toDouble() ?? size?.toDouble(),
        icon = widget is MarkerIcon ? widget : null,
        image = widget is MarkerImage ? widget : null,
        svg = widget is MarkerSvg ? widget : null,
        widget = widget is Widget ? widget : null,
        super(
          interactive: interactive,
          attribution: attribution,
          onTap: onTap,
          onTapUp: onTapUp,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          onSecondaryTap: onSecondaryTap,
          onSecondaryTapDown: onSecondaryTapDown,
          onSecondaryTapUp: onSecondaryTapUp,
          onSecondaryTapCancel: onSecondaryTapCancel,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onLongPressStart: onLongPressStart,
          onLongPressMoveUpdate: onLongPressMoveUpdate,
          onLongPressUp: onLongPressUp,
          onLongPressEnd: onLongPressEnd,
          onSecondaryLongPress: onSecondaryLongPress,
          onSecondaryLongPressStart: onSecondaryLongPressStart,
          onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
          onSecondaryLongPressUp: onSecondaryLongPressUp,
          onSecondaryLongPressEnd: onSecondaryLongPressEnd,
        );
}

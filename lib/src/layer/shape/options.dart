// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../shared.dart';
import '../layer.dart';

class ShapeLayerOptions extends PathLayerOptions {
  /// Whether to fill the path with color.
  /// Set it to `false` to disable filling on polygons or circles.
  ///
  /// Default: true
  final bool fill;

  /// Fill color.
  /// Defaults to the value of the `color` option.
  final Color? fillColor;

  /// Fill opacity.
  ///
  /// Default: 0.5
  final double fillOpacity;

  final double smoothFactor;

  const ShapeLayerOptions({
    bool? stroke = strokeDef,
    Color? strokeColor,
    num strokeWidth = strokeWidthDef,
    double strokeOpacity = strokeOpacityDef,
    StrokeCap strokeCap = strokeCapDef,
    StrokeJoin strokeJoin = strokeJoinDef,
    PathFillType pathFillType = pathFillTypeDef,
    this.fill = fillDef,
    this.fillColor,
    this.fillOpacity = fillOpacityDef,
    this.smoothFactor = smoothFactorDef,
    bool culling = cullingDef,
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
  }) : super(
          stroke: stroke,
          // by default, strokeColor will be the same as fillColor
          strokeColor: strokeColor ?? fillColor,
          strokeWidth: strokeWidth as double,
          strokeOpacity: strokeOpacity,
          strokeCap: strokeCap,
          strokeJoin: strokeJoin,
          pathFillType: pathFillType,
          culling: culling,
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

  ShapeLayerOptions copy({
    bool? stroke,
    Color? strokeColor,
    double? strokeWidth,
    double? strokeOpacity,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    PathFillType? pathFillType,
    bool? fill,
    Color? fillColor,
    double? fillOpacity,
    double? smoothFactor,
    bool? culling,
    bool? interactive,
    String? attribution,
    TapDownLayerCallback? onTapDown,
    TapUpLayerCallback? onTapUp,
    TapLayerCallback? onTap,
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
  }) {
    return ShapeLayerOptions(
      stroke: stroke ?? this.stroke,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeOpacity: strokeOpacity ?? this.strokeOpacity,
      strokeCap: strokeCap ?? this.strokeCap,
      strokeJoin: strokeJoin ?? this.strokeJoin,
      pathFillType: pathFillType ?? this.pathFillType,
      fill: fill ?? this.fill,
      fillColor: fillColor ?? this.fillColor,
      fillOpacity: fillOpacity ?? this.fillOpacity,
      smoothFactor: smoothFactor ?? this.smoothFactor,
      culling: culling ?? this.culling,
      interactive: interactive ?? this.interactive,
      onTapDown: onTapDown ?? this.onTapDown,
      onTapUp: onTapUp ?? this.onTapUp,
      onTap: onTap ?? this.onTap,
      onTapCancel: onTapCancel ?? this.onTapCancel,
      onSecondaryTap: onSecondaryTap ?? this.onSecondaryTap,
      onSecondaryTapDown: onSecondaryTapDown ?? this.onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp ?? this.onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel ?? this.onSecondaryTapCancel,
      onDoubleTap: onDoubleTap ?? this.onDoubleTap,
      onLongPress: onLongPress ?? this.onLongPress,
      onLongPressStart: onLongPressStart ?? this.onLongPressStart,
      onLongPressMoveUpdate:
          onLongPressMoveUpdate ?? this.onLongPressMoveUpdate,
      onLongPressUp: onLongPressUp ?? this.onLongPressUp,
      onLongPressEnd: onLongPressEnd ?? this.onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress ?? this.onSecondaryLongPress,
      onSecondaryLongPressStart:
          onSecondaryLongPressStart ?? this.onSecondaryLongPressStart,
      onSecondaryLongPressMoveUpdate:
          onSecondaryLongPressMoveUpdate ?? this.onSecondaryLongPressMoveUpdate,
      onSecondaryLongPressUp:
          onSecondaryLongPressUp ?? this.onSecondaryLongPressUp,
      onSecondaryLongPressEnd:
          onSecondaryLongPressEnd ?? this.onSecondaryLongPressEnd,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../shared.dart';
import '../layer.dart';

class PathLayerOptions extends InteractiveLayerOptions {
  /// Whether to draw stroke along the path.
  /// Set it to `false` to disable borders on polygons or circles.
  ///
  /// Default: false
  final bool? stroke;

  /// Stroke color
  ///
  /// Default: Colors.lightBlue
  final Color? strokeColor;

  /// Stroke width in pixels
  ///
  /// Default: 3.0
  final double strokeWidth;

  /// Stroke opacity
  ///
  /// Default: 1.0
  final double strokeOpacity;

  /// Defines shape to be used at the end.
  ///
  /// Default: StrokeCap.round
  final StrokeCap strokeCap;

  /// Defines shape to be used at the corners.
  ///
  /// Default: StrokeJoin.round
  final StrokeJoin strokeJoin;

  /// Defines how the path is painted.
  ///
  /// Default: PathFillType.evenOdd
  final PathFillType pathFillType;

  final bool culling;

  const PathLayerOptions({
    this.stroke,
    this.strokeColor = strokeColorDef,
    this.strokeWidth = strokeWidthDef,
    this.strokeOpacity = strokeOpacityDef,
    this.strokeCap = strokeCapDef,
    this.strokeJoin = strokeJoinDef,
    this.pathFillType = pathFillTypeDef,
    this.culling = cullingDef,
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

  PathLayerOptions copy({
    bool? stroke,
    Color? strokeColor,
    double? strokeWidth,
    double? strokeOpacity,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    PathFillType? pathFillType,
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
    return PathLayerOptions(
      stroke: stroke ?? this.stroke,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeOpacity: strokeOpacity ?? this.strokeOpacity,
      strokeCap: strokeCap ?? this.strokeCap,
      strokeJoin: strokeJoin ?? this.strokeJoin,
      pathFillType: pathFillType ?? this.pathFillType,
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

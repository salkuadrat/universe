import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../shared.dart';
import '../layer.dart';

typedef TapLayerCallback = void Function(dynamic position, dynamic data);
typedef TapDownLayerCallback = void Function(
    dynamic position, dynamic data, TapDownDetails details);
typedef TapUpLayerCallback = void Function(
    dynamic position, dynamic data, TapUpDetails details);
typedef DoubleTapLayerCallback = void Function(dynamic position, dynamic data);
typedef LongPressLayerCallback = void Function(dynamic position, dynamic data);
typedef LongPressStartLayerCallback = void Function(
    dynamic position, dynamic data, LongPressStartDetails details);
typedef LongPressMoveUpdateLayerCallback = void Function(
    dynamic position, dynamic data, LongPressMoveUpdateDetails details);
typedef LongPressUpLayerCallback = void Function(
    dynamic position, dynamic data);
typedef LongPressEndLayerCallback = void Function(
    dynamic position, dynamic data, LongPressEndDetails details);

class InteractiveLayerOptions extends MapLayerOptions {
  /// If `false`, the layer will not emit touch events
  /// and will act as a part of the underlying map.
  final bool interactive;

  final TapDownLayerCallback? onTapDown;
  final TapUpLayerCallback? onTapUp;
  final TapLayerCallback? onTap;
  final TapLayerCallback? onTapCancel;
  final TapLayerCallback? onSecondaryTap;
  final TapDownLayerCallback? onSecondaryTapDown;
  final TapUpLayerCallback? onSecondaryTapUp;
  final TapLayerCallback? onSecondaryTapCancel;
  final DoubleTapLayerCallback? onDoubleTap;
  final LongPressLayerCallback? onLongPress;
  final LongPressStartLayerCallback? onLongPressStart;
  final LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate;
  final LongPressUpLayerCallback? onLongPressUp;
  final LongPressEndLayerCallback? onLongPressEnd;
  final LongPressLayerCallback? onSecondaryLongPress;
  final LongPressStartLayerCallback? onSecondaryLongPressStart;
  final LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate;
  final LongPressUpLayerCallback? onSecondaryLongPressUp;
  final LongPressEndLayerCallback? onSecondaryLongPressEnd;

  bool get hasOnTap => onTap != null;
  bool get hasOnTapDown => onTapDown != null;
  bool get hasOnTapUp => onTapUp != null;
  bool get hasOnTapCancel => onTapCancel != null;
  bool get hasOnSecondaryTap => onSecondaryTap != null;
  bool get hasOnSecondaryTapDown => onSecondaryTapDown != null;
  bool get hasOnSecondaryTapUp => onSecondaryTapUp != null;
  bool get hasOnSecondaryTapCancel => onSecondaryTapCancel != null;
  bool get hasOnDoubleTap => onDoubleTap != null;
  bool get hasOnLongPress => onLongPress != null;
  bool get hasOnLongPressStart => onLongPressStart != null;
  bool get hasOnLongPressMoveUpdate => onLongPressMoveUpdate != null;
  bool get hasOnLongPressUp => onLongPressUp != null;
  bool get hasOnLongPressEnd => onLongPressEnd != null;
  bool get hasOnSecondaryLongPress => onSecondaryLongPress != null;
  bool get hasOnSecondaryLongPressStart => onSecondaryLongPressStart != null;
  bool get hasOnSecondaryLongPressMoveUpdate =>
      onSecondaryLongPressMoveUpdate != null;
  bool get hasOnSecondaryLongPressUp => onSecondaryLongPressUp != null;
  bool get hasOnSecondaryLongPressEnd => onSecondaryLongPressEnd != null;

  const InteractiveLayerOptions({
    this.interactive = interactiveDef,
    this.onTapDown,
    this.onTapUp,
    this.onTap,
    this.onTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onSecondaryLongPressStart,
    this.onSecondaryLongPressMoveUpdate,
    this.onSecondaryLongPressUp,
    this.onSecondaryLongPressEnd,
    String attribution = attributionDef,
  }) : super(attribution: attribution);

  InteractiveLayerOptions copy({
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
    return InteractiveLayerOptions(
      interactive: interactive ?? this.interactive,
      attribution: attribution ?? this.attribution,
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

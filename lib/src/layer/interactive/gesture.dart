import 'package:flutter/widgets.dart';

import '../layer.dart';

class InteractiveGestureDetector extends StatelessWidget {
  final dynamic position;
  final dynamic data;
  final Widget? child;
  final InteractiveLayerOptions? options;

  const InteractiveGestureDetector({
    Key? key,
    this.options,
    this.position,
    this.data,
    this.child,
  }) : super(key: key);

  bool get hasOnTap => options!.onTap != null;
  bool get hasOnTapDown => options!.onTapDown != null;
  bool get hasOnTapUp => options!.onTapUp != null;
  bool get hasOnTapCancel => options!.onTapCancel != null;
  bool get hasOnSecondaryTap => options!.onSecondaryTap != null;
  bool get hasOnSecondaryTapDown => options!.onSecondaryTapDown != null;
  bool get hasOnSecondaryTapUp => options!.onSecondaryTapUp != null;
  bool get hasOnSecondaryTapCancel => options!.onSecondaryTapCancel != null;
  bool get hasOnDoubleTap => options!.onDoubleTap != null;
  bool get hasOnLongPress => options!.onLongPress != null;
  bool get hasOnLongPressStart => options!.onLongPressStart != null;
  bool get hasOnLongPressMoveUpdate => options!.onLongPressMoveUpdate != null;
  bool get hasOnLongPressUp => options!.onLongPressUp != null;
  bool get hasOnLongPressEnd => options!.onLongPressEnd != null;
  bool get hasOnSecondaryLongPress => options!.onSecondaryLongPress != null;
  bool get hasOnSecondaryLongPressStart =>
      options!.onSecondaryLongPressStart != null;
  bool get hasOnSecondaryLongPressMoveUpdate =>
      options!.onSecondaryLongPressMoveUpdate != null;
  bool get hasOnSecondaryLongPressUp => options!.onSecondaryLongPressUp != null;
  bool get hasOnSecondaryLongPressEnd =>
      options!.onSecondaryLongPressEnd != null;

  @override
  Widget build(BuildContext context) {
    if (options!.interactive)
      return GestureDetector(
        onTap: hasOnTap ? () => options!.onTap?.call(position, data) : null,
        onTapUp: hasOnTapUp
            ? (details) => options!.onTapUp?.call(position, data, details)
            : null,
        onTapDown: hasOnTapDown
            ? (details) => options!.onTapDown?.call(position, data, details)
            : null,
        onTapCancel: hasOnTapCancel
            ? () => options!.onTapCancel?.call(position, data)
            : null,
        onSecondaryTap: hasOnSecondaryTap
            ? () => options!.onSecondaryTap?.call(position, data)
            : null,
        onSecondaryTapUp: hasOnSecondaryTapUp
            ? (details) =>
                options!.onSecondaryTapUp?.call(position, data, details)
            : null,
        onSecondaryTapDown: hasOnSecondaryTapDown
            ? (details) =>
                options!.onSecondaryTapDown?.call(position, data, details)
            : null,
        onSecondaryTapCancel: hasOnSecondaryTapCancel
            ? () => options!.onSecondaryTapCancel?.call(position, data)
            : null,
        onDoubleTap: hasOnDoubleTap
            ? () => options!.onDoubleTap?.call(position, data)
            : null,
        onLongPress: hasOnLongPress
            ? () => options!.onLongPress?.call(position, data)
            : null,
        onLongPressStart: hasOnLongPressStart
            ? (details) =>
                options!.onLongPressStart?.call(position, data, details)
            : null,
        onLongPressMoveUpdate: hasOnLongPressMoveUpdate
            ? (details) =>
                options!.onLongPressMoveUpdate?.call(position, data, details)
            : null,
        onLongPressEnd: hasOnLongPressEnd
            ? (details) =>
                options!.onLongPressEnd?.call(position, data, details)
            : null,
        onLongPressUp: hasOnLongPressUp
            ? () => options!.onLongPressUp?.call(position, data)
            : null,
        onSecondaryLongPress: hasOnSecondaryLongPress
            ? () => options!.onSecondaryLongPress?.call(position, data)
            : null,
        onSecondaryLongPressStart: hasOnSecondaryLongPressStart
            ? (details) => options!.onSecondaryLongPressStart
                ?.call(position, data, details)
            : null,
        onSecondaryLongPressMoveUpdate: hasOnSecondaryLongPressMoveUpdate
            ? (details) => options!.onSecondaryLongPressMoveUpdate
                ?.call(position, data, details)
            : null,
        onSecondaryLongPressEnd: hasOnSecondaryLongPressEnd
            ? (details) =>
                options!.onSecondaryLongPressEnd?.call(position, data, details)
            : null,
        onSecondaryLongPressUp: hasOnSecondaryLongPressUp
            ? () => options!.onSecondaryLongPressUp?.call(position, data)
            : null,
        child: child,
      );

    return child!;
  }
}

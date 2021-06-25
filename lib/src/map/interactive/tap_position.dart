import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Used to detect tap position on the map
class TapPositionDetector extends StatefulWidget {
  TapPositionDetector({
    Key? key,
    this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.doubleTapDelay: _DEFAULT_DELAY,
    this.behavior,
    this.controller,
  }) : super(key: key);

  static const _DEFAULT_DELAY = Duration(milliseconds: 250);
  static const _DOUBLE_TAP_MAX_OFFSET = 48.0;

  /// The widget below this widget in the tree
  final Widget? child;

  /// How to behave during hit tests
  final HitTestBehavior? behavior;

  /// Callback function to be called when tapped
  final ValueChanged<TapPosition>? onTap;

  /// Callback function to be called when double tapped
  final ValueChanged<TapPosition>? onDoubleTap;

  /// Callback function to be called when long pressed
  final ValueChanged<TapPosition>? onLongPress;

  /// Delay to count two consecutive tap as a double tap
  /// Default: 250ms
  final Duration doubleTapDelay;

  /// TapPositionController
  final TapPositionController? controller;

  @override
  _TapPositionDetectorState createState() => _TapPositionDetectorState();
}

class _TapPositionDetectorState extends State<TapPositionDetector> {
  StreamController<TapDownDetails?> _controller = StreamController();
  Stream<TapDownDetails?> get _stream => _controller.stream;
  Sink<TapDownDetails?> get _sink => _controller.sink;

  TapPositionController? _tapController;
  TapDownDetails? _pendingTap;
  TapDownDetails? _firstTap;

  @override
  void initState() {
    _updateController();
    _stream
        .timeout(widget.doubleTapDelay)
        .handleError(_onTimeout, test: (e) => e is TimeoutException)
        .listen(_onTapConfirmed);
    super.initState();
  }

  @override
  void didUpdateWidget(TapPositionDetector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateController();
    }
  }

  void _updateController() {
    _tapController?._state = null;
    if (widget.controller != null) {
      widget.controller!._state = this;
      _tapController = widget.controller;
    }
  }

  void _onTimeout(dynamic error) {
    if (_firstTap != null && _pendingTap == null) {
      _postCallback(_firstTap, widget.onTap);
    }
  }

  void _onTapConfirmed(TapDownDetails? details) {
    if (_firstTap == null) {
      _firstTap = details;
    } else {
      _handleSecondTap(details!);
    }
  }

  void _handleSecondTap(TapDownDetails secondTap) {
    if (_isDoubleTap(_firstTap!, secondTap)) {
      _postCallback(secondTap, widget.onDoubleTap);
    } else {
      _postCallback(_firstTap, widget.onTap);
      _postCallback(secondTap, widget.onTap);
    }
  }

  bool _isDoubleTap(TapDownDetails d1, TapDownDetails d2) {
    final dx = (d1.globalPosition.dx - d2.globalPosition.dx);
    final dy = (d1.globalPosition.dy - d2.globalPosition.dy);
    return sqrt(dx * dx + dy * dy) <=
        TapPositionDetector._DOUBLE_TAP_MAX_OFFSET;
  }

  void _onTapDownEvent(TapDownDetails details) {
    _pendingTap = details;
  }

  void _onTapEvent() {
    if (widget.onDoubleTap == null) {
      _postCallback(_pendingTap, widget.onTap);
    } else {
      _sink.add(_pendingTap);
    }
    _pendingTap = null;
  }

  void _onLongPressEvent() {
    if (_firstTap == null) {
      _postCallback(_pendingTap, widget.onLongPress);
    } else {
      _sink.add(_pendingTap);
      _pendingTap = null;
    }
  }

  void _postCallback(
      TapDownDetails? details, ValueChanged<TapPosition>? callback) {
    _firstTap = null;
    if (callback != null) {
      callback(_getTapPositions(details!));
    }
  }

  TapPosition _getTapPositions(TapDownDetails details) {
    final topLeft = _getWidgetTopLeft();
    final global = details.globalPosition;
    final local = topLeft != null ? global - topLeft : null;
    return TapPosition(global, local);
  }

  Offset? _getWidgetTopLeft() {
    final translation =
        context.findRenderObject()?.getTransformTo(null).getTranslation();

    return translation != null ? Offset(translation.x, translation.y) : null;
  }

  @override
  void dispose() {
    _controller.close();
    _tapController?._state = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller != null) return widget.child!;
    return GestureDetector(
      child: widget.child,
      behavior: widget.behavior,
      onTap: _onTapEvent,
      onLongPress: _onLongPressEvent,
      onTapDown: _onTapDownEvent,
    );
  }
}

class TapPosition {
  const TapPosition(this.global, this.local);

  final Offset global;
  final Offset? local;

  @override
  bool operator ==(dynamic other) {
    if (other is! TapPosition) return false;
    final TapPosition typedOther = other;
    return global == typedOther.global && local == other.local;
  }

  @override
  int get hashCode => hashValues(global, local);

  @override
  String toString() => "TapPosition(global: $global, local: $local)";
}

class TapPositionController {
  _TapPositionDetectorState? _state;

  void onTap() => _state?._onTapEvent();

  void onLongPress() => _state?._onLongPressEvent();

  void onTapDown(TapDownDetails details) => _state?._onTapDownEvent(details);
}

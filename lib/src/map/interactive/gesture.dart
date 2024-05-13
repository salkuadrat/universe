import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../core/core.dart';
import '../../shared.dart';
import '../map.dart';

/// list of methods to implements by MapGestureDetector
abstract class MapGestureMixin {
  /// When it's starting to scale
  void onScaleStart(ScaleStartDetails details);

  /// When it's scaling
  void onScaleUpdate(ScaleUpdateDetails details);

  /// When it's stop scaling
  void onScaleEnd(ScaleEndDetails details);

  /// When user tap on this widget
  void onTap(TapPosition position);

  /// When user long press on this widget
  void onLongPress(TapPosition position);

  /// When user double tap on this widget
  void onDoubleTap(TapPosition tapPosition);

  /// When user stop touching this widget
  void onTapUp(TapUpDetails details);
}

/// Widget to detect all gesture that happen on the map
class MapGestureDetector extends StatefulWidget {
  /// The widget below this widget in the tree
  final Widget? child;

  const MapGestureDetector({
    super.key,
    this.child,
  });

  @override
  State<MapGestureDetector> createState() => _MapGestureDetectorState();
}

class _MapGestureDetectorState extends State<MapGestureDetector>
    with TickerProviderStateMixin
    implements MapGestureMixin {
  MapState get map => Provider.of<MapState>(context, listen: false);

  final TapPositionController _tapPositionController = TapPositionController();

  late MapData _centerZoomStart;
  late UPoint _focalPointStart;
  LatLng? _focalLatLngStart;

  AnimationController? _flingAnimController;
  late Animation<Offset> _flingAnimation;
  Offset _flingStart = Offset.zero;

  AnimationController? _doubleTapAnimController;
  late Animation _zoomAnimation;
  late Animation _centerAnimation;

  int _tapUpCounter = 0;
  Timer? _doubleTapHoldTimer;
  final Duration _doubleTapDelay = const Duration(milliseconds: 350);

  // double _rotation = 0.0;
  double _rotationUpdate = 0.0;
  //double get _rotation => manager.angle;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _flingAnimController?.dispose();
    _doubleTapAnimController?.dispose();
    super.dispose();
  }

  void _initAnimation() {
    _flingAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(_onFling);

    _doubleTapAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(_onDoubleTapAnim);
  }

  @override
  Widget build(BuildContext context) {
    return TapPositionDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      controller: _tapPositionController,
      child: GestureDetector(
        onScaleStart: onScaleStart,
        onScaleUpdate: onScaleUpdate,
        onScaleEnd: onScaleEnd,
        onTapUp: onTapUp,
        onTap: _tapPositionController.onTap,
        onLongPress: _tapPositionController.onLongPress,
        onTapDown: _tapPositionController.onTapDown,
        child: widget.child,
      ),
    );
  }

  void _onFling() {
    final fling = _flingAnimation.value;
    final centerStart = _centerZoomStart.center;
    final centerPoint = map.project(centerStart) + map.offsetToPoint(fling);
    final center = map.unproject(centerPoint);
    map.move(center, map.zoom);
  }

  void _onDoubleTapAnim() {
    LatLng center = _centerAnimation.value;
    double zoom = _zoomAnimation.value;
    map.move(center, zoom);
  }

  void _startDoubleTapAnimation(LatLng? toCenter, double toZoom) {
    _centerAnimation = LatLngTween(begin: map.center, end: toCenter)
        .chain(CurveTween(curve: Curves.fastOutSlowIn))
        .animate(_doubleTapAnimController!);

    _zoomAnimation = Tween<double>(begin: map.zoom, end: toZoom)
        .chain(CurveTween(curve: Curves.fastOutSlowIn))
        .animate(_doubleTapAnimController!);

    _doubleTapAnimController
      ?..reset()
      ..forward();
  }

  Offset _limitFocalDelta(Offset center, Offset tap, double zoomDelta) {
    final tapDelta = tap - center;
    final scale = 1 / math.pow(2, zoomDelta);
    final maxDelta = center * (1 - scale);

    final isOutOfBounds =
        (tapDelta.dx.abs() > maxDelta.dx) || (tapDelta.dy.abs() > maxDelta.dy);

    return isOutOfBounds ? _transformFocalDelta(tapDelta, maxDelta) : tapDelta;
  }

  Offset _transformFocalDelta(Offset delta, Offset maxDelta) {
    final scaleX = delta.dx.abs() / maxDelta.dx;
    final scaleY = delta.dy.abs() / maxDelta.dy;
    return delta / math.max(scaleX, scaleY);
  }

  void _onDoubleTapHold(ScaleUpdateDetails details) {
    _doubleTapHoldTimer?.cancel();

    final projectedFocalPoint =
        projectedPoint(details.localFocalPoint, size, map.angle);
    final focalPoint = map.offsetToPoint(projectedFocalPoint);
    final diff = map.pointToOffset(_focalPointStart - focalPoint);

    final minZoom = map.minZoom;
    final maxZoom = map.maxZoom;
    final zoomStart = _centerZoomStart.zoom;

    final zoom = zoomStart - diff.dy / 360 * map.zoom;
    final toZoom = math.max(minZoom, math.min(maxZoom, zoom));

    map.move(map.center, toZoom);
  }

  @override
  void onTapUp(TapUpDetails details) {
    _doubleTapHoldTimer?.cancel();

    if (_tapUpCounter == 0) {
      _doubleTapHoldTimer = Timer(_doubleTapDelay, _resetDoubleTapHold);
      _tapUpCounter++;
    }
  }

  void _resetDoubleTapHold() {
    _doubleTapHoldTimer?.cancel();
    _tapUpCounter = 0;
  }

  @override
  void onDoubleTap(TapPosition position) {
    _resetDoubleTapHold();

    final zoom = map.getScaledZoom(map.zoom, 2.0);
    final zoomDelta = zoom - map.zoom;

    Size pjSize = projectedSize(size, map.angle);
    Offset focalPoint = projectedPoint(position.local!, size, map.angle);

    UPoint centerPoint = UPoint.from(pjSize / 2);
    Offset focalCenter = map.pointToOffset(centerPoint);
    Offset focalDelta = _limitFocalDelta(focalCenter, focalPoint, zoomDelta);

    LatLng? center = map.offsetToLatLng(
      focalCenter + focalDelta,
      pjSize.width,
      pjSize.height,
    );

    _startDoubleTapAnimation(center, zoom);
  }

  @override
  void onTap(TapPosition position) {
    final pjSize = projectedSize(size, map.angle);
    final focalPoint = projectedPoint(position.local!, size, map.angle);
    final location =
        map.offsetToLatLng(focalPoint, pjSize.width, pjSize.height);
    map.onTap?.call(location);
  }

  @override
  void onLongPress(TapPosition position) {
    _resetDoubleTapHold();

    final pjSize = projectedSize(size, map.angle);
    final focalPoint = projectedPoint(position.local!, size, map.angle);
    final location =
        map.offsetToLatLng(focalPoint, pjSize.width, pjSize.height);
    map.onLongPress?.call(location);
  }

  Size get size => Size(context.size!.width, context.size!.height);

  @override
  void onScaleStart(ScaleStartDetails details) {
    _rotationUpdate = 0.0;
    _centerZoomStart = MapData(center: map.center, zoom: map.zoom);

    if (map.canRotate) {
      map.angleStart = map.angle;
    }

    final pjSize = projectedSize(size, map.angle);
    final focalPoint = projectedPoint(details.localFocalPoint, size, map.angle);

    _focalPointStart = map.offsetToPoint(focalPoint);
    _focalLatLngStart =
        map.offsetToLatLng(focalPoint, pjSize.width, pjSize.height);

    _flingAnimController?.stop();
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details) {
    if (_tapUpCounter == 1) {
      _onDoubleTapHold(details);
      return;
    }

    _rotationUpdate = details.rotation;

    //final isScaling = details.scale < 0.96 && details.scale > 1.04;
    final isScaling = details.scale != 1.0;
    final isRotating = _rotationUpdate.abs() > (PI / 20);

    if (map.canRotate) {
      map.angle = map.angleStart + details.rotation;
    }

    if (isScaling || !isRotating) {
      final zoom = map.getScaledZoom(_centerZoomStart.zoom, details.scale);

      final pjSize = projectedSize(size, map.angle);
      final projectedFocalPoint =
          projectedPoint(details.localFocalPoint, size, map.angle);

      final halfPoint = UPoint.from(pjSize / 2);
      final focalPoint = map.offsetToPoint(projectedFocalPoint);
      final focalStartPoint = map.project(_focalLatLngStart, zoom);

      final centerPoint = halfPoint + (focalStartPoint - focalPoint);
      final center = map.unproject(centerPoint, zoom);

      map.move(center, zoom);

      _flingStart = map.pointToOffset(_focalPointStart - focalPoint);
    }
  }

  @override
  void onScaleEnd(ScaleEndDetails details) {
    _resetDoubleTapHold();

    if (map.canRotate) {
      map.angle = map.angleStart + _rotationUpdate;
    }

    final flingVelocity = details.velocity.pixelsPerSecond.distance;

    if (flingVelocity >= kMinFlingVelocity) {
      Offset direction = details.velocity.pixelsPerSecond / flingVelocity;

      final distance = math.min(size.width, size.height);
      final dd = direction * distance;

      final cos = math.cos(map.angle);
      final sin = math.sin(map.angle);

      final pdd = Offset(
        dd.dx * cos + dd.dy * sin,
        dd.dy * cos - dd.dx * sin,
      );

      final flingEnd = _flingStart - pdd;

      _flingAnimation = Tween<Offset>(
        begin: _flingStart,
        end: flingEnd,
      ).animate(_flingAnimController!);

      _flingAnimController
        ?..reset()
        ..fling(velocity: flingVelocity / 1000.0);
    }
  }
}

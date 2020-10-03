import 'dart:ui';
import 'package:curved_animation_controller/curved_animation_controller.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../../core/core.dart';
import 'grid.dart';

class Tile implements Comparable<Tile> {

  final Coordinate coordinate;
  final UPoint position;
  final Level level;
  
  ImageProvider imageProvider;
  ImageInfo imageInfo;
  ImageStream _imageStream;
  ImageStreamListener _listener;

  CurvedAnimationController _animController;
  DateTime loaded;

  bool isCurrent = false;
  bool isRetain = false;
  bool isActive = false;
  bool isLoadError = false;
  double maxOpacity;
  Function(Coordinate, Tile, dynamic) onTileReady;

  Tile({
    this.coordinate,
    this.position,
    this.imageProvider,
    this.onTileReady,
    this.level,
    this.isCurrent = false,
    this.isRetain = false,
    this.maxOpacity = 1.0,
  });

  String get key => coordinate.key;

  bool get hasAnimController => _animController != null;
  bool get hasImageProvider => imageProvider != null;
  bool get hasImage => imageInfo != null && imageInfo.image != null;

  bool get isLoaded => loaded != null;
  bool get isNotLoaded => !isLoaded;

  double get opacity => hasAnimController 
    ? (_animController.value * maxOpacity) 
    : (isActive ? maxOpacity : 0.0);

  void loadImageWith(ImageProvider imageProvider) {
    this.imageProvider = imageProvider;
    loadImage();
  }
  
  void loadImage() {
    try {
      _imageStream?.removeListener(_listener);

      _imageStream = imageProvider.resolve(ImageConfiguration());
      _listener = ImageStreamListener(_onTileLoaded, onError: _onTileError);
      _imageStream.addListener(_listener);
    } catch (e, s) {
      _onTileError(e, s);
    }
  }

  void dispose([bool evict = false]) {
    if(hasImageProvider && evict) {
      imageProvider.evict();
    }

    _imageStream?.removeListener(_listener);
    _animController?.removeStatusListener(_onAnimateEnd);
    _animController?.dispose();
  }

  void show({Duration duration, TickerProvider vsync, double from, Curve curve}) {
    _animController?.removeStatusListener(_onAnimateEnd);
    
    _animController = CurvedAnimationController(
      duration: duration, vsync: vsync, curve: curve);
    
    _animController.addStatusListener(_onAnimateEnd);
    _animController..reset()..forward(from: from);
  }

  void addAnimationListener(Function listener) {
    _animController?.addListener(listener);
  }

  void removeAnimationListener(Function listener) {
    _animController?.removeListener(listener);
  }

  void _onAnimateEnd(AnimationStatus status) {
    isActive = status == AnimationStatus.completed;
  }

  void _onTileLoaded(ImageInfo imageInfo, bool _) {
    this.imageInfo = imageInfo;
    this.isLoadError = false;
    this.loaded = DateTime.now();
    onTileReady?.call(coordinate, this, null);
  }

  void _onTileError(dynamic error, StackTrace trace) {
    this.isLoadError = true;
    onTileReady?.call(coordinate, this, 
      error ?? "Unknown error during loadTileImage");
  }

  @override
  int compareTo(Tile other) => level.zIndex.compareTo(other.level.zIndex);
  
  @override
  int get hashCode => hashValues(coordinate.hashCode, level.zIndex.hashCode);

  @override
  bool operator ==(other) => other is Tile && 
    coordinate == other.coordinate && 
    level.zIndex == other.level.zIndex;
}
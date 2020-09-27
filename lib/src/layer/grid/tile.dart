import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../../core/core.dart';
import 'grid.dart';

class Tile {

  final Coordinates coordinates;
  final UPoint position;
  final Level level;
  final Function(Coordinates, Tile, dynamic) onTileReady;

  /* final bool isCurrent;
  final bool isRetain; */

  ImageProvider imageProvider;
  ImageInfo imageInfo;
  ImageStream _imageStream;
  ImageStreamListener _listener;

  AnimationController _animController;
  DateTime loaded;
  bool isLoadError;
  bool isActive = false;

  Tile({
    this.coordinates,
    this.position,
    this.imageProvider,
    this.onTileReady,
    this.level,
    //this.isCurrent = false,
    //this.isRetain = false,
  });

  bool get hasAnimController => _animController != null;
  bool get hasImageProvider => imageProvider != null;
  bool get hasImage => imageInfo != null && imageInfo.image != null;

  double get opacity => 
    hasAnimController ? _animController.value : (isActive ? 1.0 : 0.0);
  
  void loadTile() {
    try {
      final oldImageStream = _imageStream;
      _imageStream = imageProvider.resolve(ImageConfiguration());
      
      if (_imageStream.key != oldImageStream?.key) {
        oldImageStream?.removeListener(_listener);

        _listener = ImageStreamListener(_onTileLoaded, onError: _onTileError);
        _imageStream.addListener(_listener);
      }
    } catch (e, s) {
      _onTileError(e, s);
    }
  }

  Future dispose([bool evict = false]) async {
    if(hasImageProvider && evict) {
      bool evicted = await imageProvider.evict();

      if(evicted) {
        print('evict tile success: $coordinates');
      } else {
        print('evict tile failed: $coordinates');
      }
    }

    _imageStream?.removeListener(_listener);
    _animController?.removeStatusListener(_onAnimateEnd);
    _animController?.dispose();
  }

  void show(Duration duration, TickerProvider vsync, {double from}) {
    _animController?.removeStatusListener(_onAnimateEnd);

    _animController = AnimationController(duration: duration, vsync: vsync);
    _animController.addStatusListener(_onAnimateEnd);
    _animController.forward(from: from);
  }

  void addAnimationListener(Function listener) {
    if(hasAnimController) {
      _animController.addListener(listener);
    }
  }

  void removeAnimationListener(Function listener) {
    if(hasAnimController) {
      _animController.removeListener(listener);
    }
  }

  void _onAnimateEnd(AnimationStatus status) {
    isActive = status == AnimationStatus.completed;
  }

  void _onTileLoaded(ImageInfo imageInfo, bool _) {
    this.imageInfo = imageInfo;
    this.isLoadError = false;
    this.loaded = DateTime.now();
    onTileReady?.call(coordinates, this, null);
  }

  void _onTileError(dynamic error, StackTrace trace) {
    isLoadError = true;
    onTileReady?.call(
      coordinates, this, error ?? "Unknown error during loadTileImage");
  }
  
  @override
  int get hashCode => coordinates.hashCode;

  @override
  bool operator ==(other) => other is Tile && 
    coordinates == other.coordinates && 
    level.zIndex == other.level.zIndex;
  
}
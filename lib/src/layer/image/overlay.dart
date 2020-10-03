import 'package:flutter/rendering.dart';

import '../../core/core.dart';

class ImageOverlay {
  
  final String imageUrl;
  final LatLngBounds bounds;
  final ImageProvider imageProvider;
  final ImageProvider imagePlaceholder;
  final ImageProvider imageError;
  final double opacity;
  final bool gaplessPlayback;

  bool get hasUrl => imageUrl != null && imageUrl.isNotEmpty;
  bool get hasProvider => imageProvider != null;

  ImageOverlay(dynamic image, dynamic bounds, {
    this.imagePlaceholder,
    this.imageError,
    this.opacity,
    this.gaplessPlayback,
  }) : 
    assert((image is String || image is ImageProvider) && bounds != null),
    this.imageUrl = image is String ? image : '',
    this.imageProvider = image is ImageProvider ? image : null,
    this.bounds = LatLngBounds.from(bounds);
  
  factory ImageOverlay.from(dynamic image, [dynamic bounds]) {
    if(image is ImageOverlay) return image;
    return ImageOverlay(image, bounds);
  }
}
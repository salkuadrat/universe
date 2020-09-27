import 'package:flutter/rendering.dart';

import '../../shared.dart';
import '../base/base.dart';

class ImageOverlayOptions extends LayerOptions {

  final ImageProvider imagePlaceholder;
  final ImageProvider imageError;
  final double opacity;
  final bool gaplessPlayback;

  const ImageOverlayOptions({
    this.imagePlaceholder,
    this.imageError,
    this.opacity = overlayOpacityDef,
    this.gaplessPlayback = overlayGaplessPlaybackDef,
    bool interactive = interactiveDef, 
    String attribution = attributionDef,
  }) : super(interactive: interactive, attribution: attribution);
}
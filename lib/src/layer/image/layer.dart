import 'package:flutter/widgets.dart';

import '../base/layer.dart';
import 'options.dart';

class ImageOverlay extends UniverseLayer {
  
  final ImageOverlayOptions options;

  const ImageOverlay({Key key, this.options}) 
    : super(key: key, options: options);
}
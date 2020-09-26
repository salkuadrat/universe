import 'package:flutter/widgets.dart';

import '../base/layer.dart';
import 'options.dart';

class VideoOverlay extends UniverseLayer {
  
  final VideoOverlayOptions options;

  const VideoOverlay({Key key, this.options}) 
    : super(key: key, options: options);
  
}
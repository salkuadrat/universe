import 'package:flutter/widgets.dart';

import '../layer.dart';

class InteractiveLayer extends MapLayer {

  final InteractiveLayerOptions? options;
  
  const InteractiveLayer({Key? key, this.options}): super(key: key, options: options);
  
}
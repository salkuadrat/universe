import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../layer.dart';

class InteractiveLayer extends MapLayer {
  final InteractiveLayerOptions? options;

  const InteractiveLayer({Key? key, this.options})
      : super(key: key, options: options);
}

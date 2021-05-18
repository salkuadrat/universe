import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../layer.dart';

class PathLayer extends InteractiveLayer {
  final PathLayerOptions? options;

  const PathLayer({Key? key, this.options}) : super(key: key, options: options);
}

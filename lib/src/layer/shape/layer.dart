import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../layer.dart';

class ShapeLayer extends PathLayer {
  final ShapeLayerOptions? options;

  const ShapeLayer({Key? key, this.options})
      : super(key: key, options: options);
}

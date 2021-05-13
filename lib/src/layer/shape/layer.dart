import 'package:flutter/widgets.dart';

import '../layer.dart';

class ShapeLayer extends PathLayer {
  
  final ShapeLayerOptions? options;

  const ShapeLayer({Key? key, this.options}) : super(key: key, options: options);
}
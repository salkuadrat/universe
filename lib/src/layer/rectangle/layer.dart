import 'package:flutter/widgets.dart';

import '../base/layer.dart';
import 'options.dart';

class RectangleLayer extends UniverseLayer {

  final RectangleLayerOptions options;

  const RectangleLayer({Key key, this.options}) 
    : super(key: key, options: options);
}

class MultiRectangleLayer extends StatelessWidget {

  final MultiRectangleLayerOptions options;

  const MultiRectangleLayer({Key key, this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
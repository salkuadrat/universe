import 'package:flutter/widgets.dart';

import '../base/layer.dart';
import 'options.dart';

class PolygonLayer extends UniverseLayer {
  final PolygonLayerOptions options;

  const PolygonLayer({Key key, this.options}) 
    : super(key: key, options: options);
}

class MultiPolygonLayer extends StatelessWidget {

  final MultiPolygonLayerOptions options;

  const MultiPolygonLayer({Key key, this.options}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
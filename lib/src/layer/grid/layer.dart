import 'package:flutter/widgets.dart';

import '../../map/map.dart';
import '../layer.dart';

class GridLayer extends MapLayer {

  final GridLayerOptions options;

  const GridLayer({Key key, this.options})
    : super(key: key, options: options);
  
  @override 
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return Container();
  }
}
import 'package:flutter/widgets.dart';

import '../../map/map.dart';
import '../layer.dart';

class GroupLayer extends SingleLayer {

  final List<SingleLayer> layers;
  final GroupLayerOptions options;
  
  GroupLayer(this.layers, {Key key, this.options}) 
    : super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return Stack(
      children: layers,
    );
  }
}
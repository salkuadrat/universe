import 'package:flutter/widgets.dart';

import '../../map/controller/base.dart';
import '../../map/state.dart';
import '../../layer/base/layer.dart';
import 'options.dart';

class GroupLayer extends UniverseLayer {

  final GroupLayerOptions options;
  
  GroupLayer({Key key, this.options}) 
    : super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return Stack(
      children: options.layers,
    );
  }
}
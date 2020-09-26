import 'package:flutter/widgets.dart';

import '../../map/controller/base.dart';
import '../../map/state.dart';
import '../base/layer.dart';
import 'options.dart';

class MarkerLayer extends UniverseLayer {

  final MarkerLayerOptions options;

  const MarkerLayer({Key key, this.options}): super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapController controller, MapState state) {
    return Container();
  }
}
import 'package:flutter/widgets.dart';

import '../../map/map.dart';
import '../layer.dart';

class MarkerLayer extends SingleLayer {

  final MarkerLayerOptions options;

  const MarkerLayer({Key key, this.options}): super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapController controller, MapState state) {
    return Container();
  }
}
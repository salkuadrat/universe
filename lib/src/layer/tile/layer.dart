import 'package:flutter/widgets.dart';
import 'package:universe/src/layer/tile/options.dart';

import '../../map/controller/base.dart';
import '../../map/state.dart';
import '../base/layer.dart';

class TileLayer extends UniverseLayer {

  final TileLayerOptions options;

  const TileLayer({Key key, this.options}) 
    : super(key: key, options: options);
  
  @override
  Widget buildLayer(BuildContext context, MapController controller, MapState state) {
    return Container();
  }
}
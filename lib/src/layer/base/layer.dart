import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../map/map.dart';
import 'options.dart';

class MapLayer extends StatelessWidget {
  
  const MapLayer({Key? key, MapLayerOptions? options}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Consumer<MapStates>(
      builder: (context, map, child) => buildLayer(context, map),
    );
  }

  /// override this function for every map layers
  Widget buildLayer(BuildContext context, MapStates map) {
    return Container();
  }
}
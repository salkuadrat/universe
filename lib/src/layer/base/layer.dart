import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../map/map.dart';
import 'options.dart';

class MapLayer extends StatelessWidget {
  const MapLayer({Key? key, MapLayerOptions? options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MapState>(
      builder: (context, map, child) => buildLayer(context, map),
    );
  }

  /// override this function for every map layers
  Widget buildLayer(BuildContext context, MapState map) {
    return Container();
  }
}

import 'package:flutter/widgets.dart';
import 'package:universe/src/shared.dart';

import '../../map/map.dart';
import '../layer.dart';

class GroupLayer extends InteractiveLayer {
  final List<MapLayer>? layers;
  final GroupLayerOptions? options;

  const GroupLayer({Key? key, this.layers, this.options})
      : super(key: key, options: options);

  @override
  Widget buildLayer(BuildContext context, MapStates map) {
    return Transform.rotate(
      angle: degToRadian(options?.rotation ?? map.options.rotation),
      child: Opacity(
        opacity: options?.opacity ?? 1.0,
        child: Stack(children: layers!),
      ),
    );
  }
}

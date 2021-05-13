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
  Widget buildLayer(BuildContext context, MapController? controller, MapState map) {
    // TODO transfer options from GroupLayer to every child layers
    return Transform.rotate(
      angle: degToRadian(options!.rotation),
      child: Opacity(
        opacity: options!.opacity,
        child: Stack(children: layers!),
      ),
    );
  }
}
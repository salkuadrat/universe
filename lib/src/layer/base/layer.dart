import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import '../../map/map.dart';
import 'options.dart';

class MapLayer extends StatelessWidget {
  
  const MapLayer({Key key, LayerOptions options}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CubitBuilder<MapStateManager, MapState>(
      buildWhen: (old, current) {
        return 
          old.center == null || old.zoom == null || 
          (current.center.notEqual(old.center)) ||  
          (current.isNotEqualZoom(old.zoom)) || 
          (current.bounds != old.bounds) || 
          (current.rotation != old.rotation);
      },
      builder: (context, map) => buildLayer(
        context, 
        map.controller, 
        map,
      ),
    );
  }

  /// override this build function for every layers
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return Container();
  }
}
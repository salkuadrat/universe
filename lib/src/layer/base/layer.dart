import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:universe/src/layer/base/options.dart';

import '../../map/controller/base.dart';
import '../../map/manager.dart';
import '../../map/state.dart';

class UniverseLayer extends StatelessWidget {
  const UniverseLayer({Key key, LayerOptions options}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CubitBuilder<MapManager, MapState>(
      builder: (context, state) => buildLayer(
        context, 
        state.controller, 
        state,
      ),
    );
  }

  /// override this build function for every layers
  /// TODO how to force children to override this function??
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return Container();
  }
}
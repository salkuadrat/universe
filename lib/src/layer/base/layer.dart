import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import '../../map/map.dart';
import 'options.dart';

class SingleLayer extends StatelessWidget {
  const SingleLayer({Key key, LayerOptions options}) : super(key: key);
  
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
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    return Container();
  }
}
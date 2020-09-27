import '../../shared.dart';
import '../layer.dart';

class GroupLayerOptions extends LayerOptions {
  const GroupLayerOptions({
    bool interactive = interactiveDef,
    String attribution = attributionDef,
  }) : super(
    interactive: interactive, 
    attribution: attribution,
  );
}
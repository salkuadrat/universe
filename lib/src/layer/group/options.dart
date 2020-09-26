import '../base/layer.dart';
import '../base/options.dart';

class GroupLayerOptions extends LayerOptions {

  final List<UniverseLayer> layers;

  GroupLayerOptions(this.layers);
}
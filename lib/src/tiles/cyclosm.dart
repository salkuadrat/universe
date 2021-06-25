import '../layer/layer.dart';
import '../shared.dart';

/// Set template URL for CyclOSM.
TileLayerOptions cyclosm({required TileLayerOptions options}) {
  return options.copy(
    templateUrl:
        'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
    attribution: 'CyclOSM | $osmAttrDef',
    maxZoom: 20,
  );
}

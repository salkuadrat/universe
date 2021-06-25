import '../layer/layer.dart';
import '../shared.dart';

/// Set template URL for MtbMap.
TileLayerOptions mtbmap({required TileLayerOptions options}) {
  return options.copy(
    templateUrl: 'http://tile.mtbmap.cz/mtbmap_tiles/{z}/{x}/{y}.png',
    attribution: '$osmAttrDef &amp; USGS',
  );
}

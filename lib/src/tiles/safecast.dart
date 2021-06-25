import '../layer/layer.dart';
import '../shared.dart';

/// Set template URL for SafeCast.
TileLayerOptions safecast({required TileLayerOptions options}) {
  return options.copy(
    templateUrl: 'https://s3.amazonaws.com/te512.safecast.org/{z}/{x}/{y}.png',
    attribution: '$osmAttrDef | Map style: &copy; SafeCast (CC-BY-SA)',
    maxZoom: 16,
  );
}

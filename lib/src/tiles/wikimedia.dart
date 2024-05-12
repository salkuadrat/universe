import '../layer/layer.dart';

/// Set template URL for Wikimedia Map.
TileLayerOptions wikimedia({required TileLayerOptions options}) {
  return options.copy(
    templateUrl: 'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}{r}.png',
    attribution: 'Wikimedia',
    maxZoom: 19,
    minZoom: 1,
  );
}

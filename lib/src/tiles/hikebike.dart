import '../layer/layer.dart';

/// Set template URL for HikeBike Map.
TileLayerOptions hikebike({required TileLayerOptions options}) {
  return options.copy(
    templateUrl: 'https://{s}.tiles.wmflabs.org/hillshading/{z}/{x}/{y}.png',
    attribution: 'Map data &copy; OpenStreetMap contributors',
    maxZoom: 15,
  );
}

import '../layer/layer.dart';

/// Set template URL for NLSMap.
TileLayerOptions nls({required TileLayerOptions options}) {
  return options.copy(
    templateUrl: 'https://nls-{s}.tileserver.com/nls/{z}/{x}/{y}.jpg',
    attribution: 'National Library of Scotland Historic Maps',
    bounds: [
      [49.6, -12],
      [61.7, 3]
    ],
    subdomains: '0123',
    maxZoom: 18,
    minZoom: 1,
  );
}

import '../layer/layer.dart';
import '../type.dart';

/// Mapping NLMapsType to its template URL.
TileLayerOptions nlmaps({
  required NLMapsType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    attribution: 'Kaartgegevens &copy; Kadaster',
    maxZoom: 19,
    minZoom: 6,
    bounds: [
      [50.5, 3.25],
      [54, 7.6]
    ],
  );

  switch (type) {
    case NLMapsType.Default:
      return opts.copy(
        templateUrl:
            'https://geodata.nationaalgeoregister.nl/tiles/service/wmts/brtachtergrondkaart/EPSG:3857/{z}/{x}/{y}.png',
      );
    case NLMapsType.Pastel:
      return opts.copy(
        templateUrl:
            'https://geodata.nationaalgeoregister.nl/tiles/service/wmts/brtachtergrondkaartpastel/EPSG:3857/{z}/{x}/{y}.png',
      );
    case NLMapsType.Grijs:
      return opts.copy(
        templateUrl:
            'https://geodata.nationaalgeoregister.nl/tiles/service/wmts/brtachtergrondkaartgrijs/EPSG:3857/{z}/{x}/{y}.png',
      );
    case NLMapsType.Luchtfoto:
      return opts.copy(
        templateUrl:
            'https://geodata.nationaalgeoregister.nl/luchtfoto/rgb/wmts/2018_ortho25/EPSG:3857/{z}/{x}/{y}.png',
      );
  }
}

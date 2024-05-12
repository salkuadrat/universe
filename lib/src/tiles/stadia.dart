import '../layer/layer.dart';
import '../type.dart';

/// Mapping StadiaType to its template URL.
TileLayerOptions stadia({
  required String apikey,
  required StadiaType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    attribution:
        '&copy; Stadia Maps, &copy; OpenMapTiles, &copy; OpenStreetMap contributors',
    maxZoom: 20,
  );

  switch (type) {
    case StadiaType.AlidadeSmooth:
      return opts.copy(
        templateUrl:
            'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png?api_key=$apikey',
      );
    case StadiaType.AlidadeSmoothDark:
      return opts.copy(
        templateUrl:
            'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png?api_key=$apikey',
      );
    case StadiaType.OSMBright:
      return opts.copy(
        templateUrl:
            'https://tiles.stadiamaps.com/tiles/osm_bright/{z}/{x}/{y}{r}.png?api_key=$apikey',
      );
    case StadiaType.OSMOutdoors:
      return opts.copy(
        templateUrl:
            'https://tiles.stadiamaps.com/tiles/outdoors/{z}/{x}/{y}{r}.png?api_key=$apikey',
      );
  }
}

import '../layer/layer.dart';
import '../type.dart';

/// Mapping BasemapATType to its template URL.
TileLayerOptions basemapat({
  required BasemapATType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    subdomains: ['', '1', '2', '3', '4'],
    attribution: 'Datenquelle: basemap.at',
    maxZoom: 19,
    bounds: [
      [46.358770, 8.782379],
      [49.037872, 17.189532]
    ],
  );

  switch (type) {
    case BasemapATType.Default:
      return opts.copy(
        templateUrl:
            'https://maps{s}.wien.gv.at/basemap/geolandbasemap/normal/google3857/{z}/{y}/{x}.png',
        maxZoom: 20,
      );
    case BasemapATType.Grau:
      return opts.copy(
        templateUrl:
            'https://maps{s}.wien.gv.at/basemap/bmapgrau/normal/google3857/{z}/{y}/{x}.png',
      );
    case BasemapATType.Overlay:
      return opts.copy(
        templateUrl:
            'https://maps{s}.wien.gv.at/basemap/bmapoverlay/normal/google3857/{z}/{y}/{x}.png',
      );
    case BasemapATType.Terrain:
      return opts.copy(
        templateUrl:
            'https://maps{s}.wien.gv.at/basemap/bmapgelaende/grau/google3857/{z}/{y}/{x}.jpeg',
      );
    case BasemapATType.Surface:
      return opts.copy(
        templateUrl:
            'https://maps{s}.wien.gv.at/basemap/bmapoberflaeche/grau/google3857/{z}/{y}/{x}.jpeg',
      );
    case BasemapATType.Hdpi:
      return opts.copy(
        templateUrl:
            'https://maps{s}.wien.gv.at/basemap/bmaphidpi/normal/google3857/{z}/{y}/{x}.jpeg',
      );
    case BasemapATType.Orthofoto:
      return opts.copy(
        templateUrl:
            'https://maps{s}.wien.gv.at/basemap/bmaporthofoto30cm/normal/google3857/{z}/{y}/{x}.jpeg',
        maxZoom: 20,
      );
  }
}

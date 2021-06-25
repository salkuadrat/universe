import '../layer/layer.dart';
import '../shared.dart';
import '../type.dart';

/// Mapping OpenStreetMapType to its template URL.
TileLayerOptions osm({
  required OpenStreetMapType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    attribution: osmAttrDef,
    maxZoom: 18,
  );

  switch (type) {
    case OpenStreetMapType.Mapnik:
      return opts.copy(
        templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        maxZoom: 19,
      );
    case OpenStreetMapType.HOT:
      return opts.copy(
        templateUrl: 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
        attribution:
            '$osmAttrDef, Tiles style by Humanitarian OpenStreetMap Team hosted by OpenStreetMap France',
      );
    case OpenStreetMapType.DE:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png',
      );
    case OpenStreetMapType.CH:
      return opts.copy(
        templateUrl: 'https://tile.osm.ch/switzerland/{z}/{x}/{y}.png',
        bounds: [
          [45, 5],
          [48, 11]
        ],
      );
    case OpenStreetMapType.France:
      return opts.copy(
        templateUrl: 'https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png',
        attribution: '&copy; Openstreetmap France | $osmAttrDef',
        maxZoom: 20,
      );
    case OpenStreetMapType.BZH:
      return opts.copy(
        templateUrl: 'https://tile.openstreetmap.bzh/br/{z}/{x}/{y}.png',
        attribution: '$osmAttrDef, Tiles courtesy of Breton OpenStreetMap Team',
        bounds: [
          [46.2, -5.5],
          [50, 0.7]
        ],
      );
  }
}

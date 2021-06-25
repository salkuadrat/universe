import '../layer/layer.dart';
import '../type.dart';

/// Mapping GeoportailFranceType to its template URL.
// Get your own geoportail apikey here : http://professionnels.ign.fr/ign/contrats/
// NB : 'choisirgeoportail' is a demonstration key that comes with no guarantee
TileLayerOptions geoportail({
  required String apikey,
  required GeoportailFranceType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    attribution: 'Geoportail France',
    minZoom: 2,
    maxZoom: 18,
    bounds: [
      [-75, -180],
      [81, 180]
    ],
  );

  switch (type) {
    case GeoportailFranceType.Plan:
      return opts.copy(
        templateUrl:
            'https://wxs.ign.fr/$apikey/geoportail/wmts?REQUEST=GetTile&SERVICE=WMTS&VERSION=1.0.0&STYLE=normal&TILEMATRIXSET=PM&FORMAT=image/png&LAYER=GEOGRAPHICALGRIDSYSTEMS.PLANIGNV2&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}',
      );
    case GeoportailFranceType.Parcels:
      return opts.copy(
        templateUrl:
            'https://wxs.ign.fr/$apikey/geoportail/wmts?REQUEST=GetTile&SERVICE=WMTS&VERSION=1.0.0&STYLE=PCI vecteur&TILEMATRIXSET=PM&FORMAT=image/png&LAYER=CADASTRALPARCELS.PARCELLAIRE_EXPRESS&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}',
      );
    case GeoportailFranceType.Orthos:
      return opts.copy(
        templateUrl:
            'https://wxs.ign.fr/$apikey/geoportail/wmts?REQUEST=GetTile&SERVICE=WMTS&VERSION=1.0.0&STYLE=normal&TILEMATRIXSET=PM&FORMAT=image/jpeg&LAYER=ORTHOIMAGERY.ORTHOPHOTOS&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}',
      );
  }
}

import '../layer/layer.dart';
import '../type.dart';

/// Mapping USGSType to its template URL.
TileLayerOptions usgs({
  required USGSType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    attribution: 'Tiles courtesy of the U.S. Geological Survey',
    maxZoom: 20,
  );

  switch (type) {
    case USGSType.Topo:
      return opts.copy(
        templateUrl:
            'https://basemap.nationalmap.gov/arcgis/rest/services/USGSTopo/MapServer/tile/{z}/{y}/{x}',
      );
    case USGSType.Imagery:
      return opts.copy(
        templateUrl:
            'https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryOnly/MapServer/tile/{z}/{y}/{x}',
      );
    case USGSType.ImageryTopo:
      return opts.copy(
        templateUrl:
            'https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryTopo/MapServer/tile/{z}/{y}/{x}',
      );
  }
}

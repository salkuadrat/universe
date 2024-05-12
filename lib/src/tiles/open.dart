import '../layer/layer.dart';
import '../shared.dart';
import '../type.dart';

/// Mapping OpenType to its template URL.
TileLayerOptions open({
  required OpenType type,
  required TileLayerOptions options,
}) {
  switch (type) {
    case OpenType.OpenSeaMap:
      return options.copy(
        templateUrl: 'https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png',
        attribution: 'Map data: &copy; OpenSeaMap contributors',
      );
    case OpenType.OpenTopoMap:
      return options.copy(
        templateUrl: 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
        attribution:
            '$osmAttrDef, SRTM | Map style: &copy; OpenTopoMap (CC-BY-SA)',
        maxZoom: 17,
      );
    case OpenType.OpenRailwayMap:
      return options.copy(
        templateUrl:
            'https://{s}.tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png',
        attribution:
            '$osmAttrDef | Map style: &copy; OpenRailwayMap (CC-BY-SA)',
        maxZoom: 19,
      );
    case OpenType.OpenFireMap:
      return options.copy(
        templateUrl: 'http://www.openfiremap.de/hytiles/{z}/{x}/{y}.png',
        attribution: '$osmAttrDef | Map style: &copy; OpenFireMap (CC-BY-SA)',
        maxZoom: 19,
      );
    case OpenType.OpenSnowMap:
      return options.copy(
        templateUrl: 'https://tiles.opensnowmap.org/pistes/{z}/{x}/{y}.png',
        attribution:
            '$osmAttrDef & ODbL, &copy; www.opensnowmap.org (CC-BY-SA)',
        maxZoom: 18,
        minZoom: 9,
      );
    case OpenType.OpenAIP:
      return options.copy(
        subdomains: ['1', '2'],
        templateUrl:
            'http://{s}.tile.maps.openaip.net/geowebcache/service/tms/1.0.0/openaip_basemap@EPSG%3A900913@png/{z}/{x}/{y}.png',
        attribution: 'OpenAIP Data (CC-BY-NC-SA)',
        maxZoom: 14,
        minZoom: 4,
        retinaMode: true,
        tms: true,
      );
  }
}

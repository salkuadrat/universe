import 'package:universe/src/shared.dart';

import 'layer/layer.dart';
import 'type.dart';

TileLayerOptions google(GoogleMapType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    templateUrl: 'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
    subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
    attribution: 'Map Data &copy; Google',
  );

  if (type == GoogleMapType.Street) {
    return opts.copy(
      templateUrl: 'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
    );
  }

  if (type == GoogleMapType.Satellite) {
    return opts.copy(
      templateUrl: 'https://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}',
    );
  }

  if (type == GoogleMapType.Hybrid) {
    return opts.copy(
      templateUrl: 'https://{s}.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
    );
  }

  if (type == GoogleMapType.Terrain) {
    return opts.copy(
      templateUrl: 'https://{s}.google.com/vt/lyrs=p&x={x}&y={y}&z={z}',
    );
  }

  return opts;
}

TileLayerOptions mapbox(
    MapBoxType type, TileLayerOptions options, String accessToken) {
  TileLayerOptions opts = options.copy(
    tileSize: 512,
    maxZoom: 18,
    zoomOffset: -1,
    attribution:
        'Map data &copy; OpenStreetMap contributors, Imagery &copy; MapBox',
    templateUrl:
        'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=$accessToken',
  );

  if (type == MapBoxType.Basic) {
    return opts.copy(
      templateUrl:
          'https://api.mapbox.com/styles/v1/mapbox/basic-v9/tiles/{z}/{x}/{y}?access_token=$accessToken',
    );
  }

  if (type == MapBoxType.Street) {
    return opts.copy(
      templateUrl:
          'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=$accessToken',
    );
  }

  if (type == MapBoxType.Satellite) {
    return opts.copy(
      templateUrl:
          'https://api.mapbox.com/styles/v1/mapbox/satellite-v9/tiles/{z}/{x}/{y}?access_token=$accessToken',
    );
  }

  if (type == MapBoxType.Hybrid) {
    return opts.copy(
      templateUrl:
          'https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v11/tiles/{z}/{x}/{y}?access_token=$accessToken',
    );
  }

  if (type == MapBoxType.Outdoors) {
    return opts.copy(
      templateUrl:
          'https://api.mapbox.com/styles/v1/mapbox/outdoors-v11/tiles/{z}/{x}/{y}?access_token=$accessToken',
    );
  }

  if (type == MapBoxType.Dark) {
    return opts.copy(
      templateUrl:
          'https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/{z}/{x}/{y}?access_token=$accessToken',
    );
  }

  if (type == MapBoxType.Light) {
    return opts.copy(
      templateUrl:
          'https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/{z}/{x}/{y}?access_token=$accessToken',
    );
  }

  if (type == MapBoxType.Bright) {
    return opts.copy(
      templateUrl:
          'https://api.mapbox.com/styles/v1/mapbox/bright-v9/tiles/{z}/{x}/{y}?access_token=$accessToken',
    );
  }

  return opts;
}

TileLayerOptions osm(OpenStreetMapType type, TileLayerOptions options) {
  double maxZoom = 18;

  if (type == OpenStreetMapType.Mapnik) {
    return options.copy(
      templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      attribution: osmAttrDef,
      maxZoom: 19,
    );
  }

  if (type == OpenStreetMapType.DE) {
    return options.copy(
        templateUrl:
            'https://{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png',
        attribution: osmAttrDef,
        maxZoom: maxZoom);
  }

  if (type == OpenStreetMapType.CH) {
    return options.copy(
      templateUrl: 'https://tile.osm.ch/switzerland/{z}/{x}/{y}.png',
      bounds: [
        [45, 5],
        [48, 11]
      ],
      attribution: osmAttrDef,
      maxZoom: maxZoom,
    );
  }

  if (type == OpenStreetMapType.France) {
    return options.copy(
      templateUrl: 'https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png',
      attribution: '&copy; Openstreetmap France | $osmAttrDef',
      maxZoom: 20,
    );
  }

  if (type == OpenStreetMapType.HOT) {
    return options.copy(
        templateUrl: 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
        attribution:
            '$osmAttrDef, Tiles style by Humanitarian OpenStreetMap Team hosted by OpenStreetMap France');
  }

  if (type == OpenStreetMapType.BZH) {
    return options.copy(
      templateUrl: 'https://tile.openstreetmap.bzh/br/{z}/{x}/{y}.png',
      attribution: '$osmAttrDef, Tiles courtesy of Breton OpenStreetMap Team',
      bounds: [
        [46.2, -5.5],
        [50, 0.7]
      ],
    );
  }

  return options;
}

TileLayerOptions safecast(TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://s3.amazonaws.com/te512.safecast.org/{z}/{x}/{y}.png',
    attribution: '$osmAttrDef | Map style: &copy; SafeCast (CC-BY-SA)',
    maxZoom: 16,
  );
}

TileLayerOptions cyclosm(TileLayerOptions options) {
  return options.copy(
    templateUrl:
        'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
    attribution: 'CyclOSM | $osmAttrDef',
    maxZoom: 20,
  );
}

TileLayerOptions freemapsk(TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.freemap.sk/T/{z}/{x}/{y}.jpeg',
    attribution: '$osmAttrDef, vizualization CC-By-SA 2.0 Freemap.sk',
    bounds: [
      [47.204642, 15.996093],
      [49.830896, 22.576904]
    ],
    subdomains: 'abcd',
    maxZoom: 16,
    minZoom: 8,
  );
}

TileLayerOptions mtbmap(TileLayerOptions options) {
  return options.copy(
    templateUrl: 'http://tile.mtbmap.cz/mtbmap_tiles/{z}/{x}/{y}.png',
    attribution: '$osmAttrDef &amp; USGS',
  );
}

TileLayerOptions nls(TileLayerOptions options) {
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

TileLayerOptions wikimedia(TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}{r}.png',
    attribution: 'Wikimedia',
    maxZoom: 19,
    minZoom: 1,
  );
}

TileLayerOptions open(OpenType type, TileLayerOptions options) {
  if (type == OpenType.OpenSeaMap) {
    return options.copy(
        templateUrl: 'https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png',
        attribution: 'Map data: &copy; OpenSeaMap contributors');
  }

  if (type == OpenType.OpenPtMap) {
    return options.copy(
      templateUrl: 'http://openptmap.org/tiles/{z}/{x}/{y}.png',
      attribution: 'Map data: &copy; OpenPtMap contributors',
      maxZoom: 17,
    );
  }

  if (type == OpenType.OpenTopoMap) {
    return options.copy(
      templateUrl: 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
      attribution:
          '$osmAttrDef, SRTM | Map style: &copy; OpenTopoMap (CC-BY-SA)',
      maxZoom: 17,
    );
  }

  if (type == OpenType.OpenRailwayMap) {
    return options.copy(
      templateUrl:
          'https://{s}.tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png',
      attribution: '$osmAttrDef | Map style: &copy; OpenRailwayMap (CC-BY-SA)',
      maxZoom: 19,
    );
  }

  if (type == OpenType.OpenFireMap) {
    return options.copy(
      templateUrl: 'http://openfiremap.org/hytiles/{z}/{x}/{y}.png',
      attribution: '$osmAttrDef | Map style: &copy; OpenFireMap (CC-BY-SA)',
      maxZoom: 19,
    );
  }

  if (type == OpenType.OpenSnowMap) {
    return options.copy(
      templateUrl: 'https://tiles.opensnowmap.org/pistes/{z}/{x}/{y}.png',
      attribution: '$osmAttrDef & ODbL, &copy; www.opensnowmap.org (CC-BY-SA)',
      maxZoom: 18,
      minZoom: 9,
    );
  }

  if (type == OpenType.OpenAIP) {
    return options.copy(
      subdomains: '12',
      templateUrl:
          'http://{s}.tile.maps.openaip.net/geowebcache/service/tms/1.0.0/openaip_basemap@EPSG%3A900913@png/{z}/{x}/{y}.png',
      attribution: 'OpenAIP Data (CC-BY-NC-SA)',
      maxZoom: 14,
      minZoom: 4,
      retinaMode: true,
      tms: true,
    );
  }

  return options;
}

TileLayerOptions stadia(StadiaType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    attribution:
        '&copy; Stadia Maps, &copy; OpenMapTiles, &copy; OpenStreetMap contributors',
    maxZoom: 20,
  );

  if (type == StadiaType.AlidadeSmooth) {
    return opts.copy(
      templateUrl:
          'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == StadiaType.AlidadeSmoothDark) {
    return opts.copy(
      templateUrl:
          'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == StadiaType.OSMBright) {
    return opts.copy(
      templateUrl:
          'https://tiles.stadiamaps.com/tiles/osm_bright/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == StadiaType.OSMOutdoors) {
    return opts.copy(
      templateUrl:
          'https://tiles.stadiamaps.com/tiles/outdoors/{z}/{x}/{y}{r}.png',
    );
  }

  return opts;
}

TileLayerOptions thunderforest(
    ThunderforestType type, TileLayerOptions options, String apikey) {
  TileLayerOptions opts = options.copy(
    attribution: '&copy; Thunderforest, &copy; OpenStreetMap contributors',
    maxZoom: 22,
  );

  if (type == ThunderforestType.Cycle) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.thunderforest.com/cycle/{z}/{x}/{y}.png?apikey=$apikey',
    );
  }

  if (type == ThunderforestType.Landscape) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.thunderforest.com/landscape/{z}/{x}/{y}.png?apikey=$apikey',
    );
  }

  if (type == ThunderforestType.Outdoors) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.thunderforest.com/outdoors/{z}/{x}/{y}.png?apikey=$apikey',
    );
  }

  if (type == ThunderforestType.MobileAtlas) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.thunderforest.com/mobile-atlas/{z}/{x}/{y}.png?apikey=$apikey',
    );
  }

  if (type == ThunderforestType.Neighbourhood) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.thunderforest.com/neighbourhood/{z}/{x}/{y}.png?apikey=$apikey',
    );
  }

  if (type == ThunderforestType.Pioneer) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.thunderforest.com/pioneer/{z}/{x}/{y}.png?apikey=$apikey',
    );
  }

  if (type == ThunderforestType.Spinal) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.thunderforest.com/spinal-map/{z}/{x}/{y}.png?apikey=$apikey',
    );
  }

  if (type == ThunderforestType.Transport) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=$apikey',
    );
  }

  if (type == ThunderforestType.TransportDark) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.thunderforest.com/transport-dark/{z}/{x}/{y}.png?apikey=$apikey',
    );
  }

  return options;
}

TileLayerOptions hydda(HyddaType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    attribution:
        'Tiles courtesy of OpenStreetMap Sweden &mdash; Map Data &copy; OpenStreetMap contributors',
    maxZoom: 20,
  );

  if (type == HyddaType.Full) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.openstreetmap.se/hydda/full/{z}/{x}/{y}.png',
    );
  }

  if (type == HyddaType.Base) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.openstreetmap.se/hydda/base/{z}/{x}/{y}.png',
    );
  }

  if (type == HyddaType.RoadsLabels) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.openstreetmap.se/hydda/roads_and_labels/{z}/{x}/{y}.png',
    );
  }

  return opts;
}

TileLayerOptions jawg(JawgType type, TileLayerOptions options, String apikey) {
  TileLayerOptions opts = options.copy(
    subdomains: 'abcd',
    attribution: '&copy; Jawg Maps, &copy; OpenStreetMap contributors',
    maxZoom: 22,
  );

  if (type == JawgType.Dark) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.jawg.io/jawg-dark/{z}/{x}/{y}{r}.png?access-token=$apikey',
    );
  }

  if (type == JawgType.Light) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.jawg.io/jawg-light/{z}/{x}/{y}{r}.png?access-token=$apikey',
    );
  }

  if (type == JawgType.Matrix) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.jawg.io/jawg-matrix/{z}/{x}/{y}{r}.png?access-token=$apikey',
    );
  }

  if (type == JawgType.Streets) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.jawg.io/jawg-streets/{z}/{x}/{y}{r}.png?access-token=$apikey',
    );
  }

  if (type == JawgType.Sunny) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.jawg.io/jawg-sunny/{z}/{x}/{y}{r}.png?access-token=$apikey',
    );
  }

  if (type == JawgType.Terrain) {
    return opts.copy(
      templateUrl:
          'https://{s}.tile.jawg.io/jawg-terrain/{z}/{x}/{y}{r}.png?access-token=$apikey',
    );
  }

  return opts;
}

TileLayerOptions maptiler(
    MapTilerType type, TileLayerOptions options, String apikey) {
  TileLayerOptions opts = options.copy(
    subdomains: 'abcd',
    attribution: '&copy; MapTiler, &copy; OpenStreetMap contributors',
    tileSize: 512,
    zoomOffset: -1,
    maxZoom: 21,
  );

  if (type == MapTilerType.Default || type == MapTilerType.Streets) {
    return opts.copy(
      templateUrl:
          'https://api.maptiler.com/maps/streets/{z}/{x}/{y}{r}.png?key=$apikey',
    );
  }

  if (type == MapTilerType.Basic) {
    return opts.copy(
      templateUrl:
          'https://api.maptiler.com/maps/basic/{z}/{x}/{y}{r}.png?key=$apikey',
    );
  }

  if (type == MapTilerType.Bright) {
    return opts.copy(
      templateUrl:
          'https://api.maptiler.com/maps/bright/{z}/{x}/{y}{r}.png?key=$apikey',
    );
  }

  if (type == MapTilerType.Pastel) {
    return opts.copy(
      templateUrl:
          'https://api.maptiler.com/maps/pastel/{z}/{x}/{y}{r}.png?key=$apikey',
    );
  }

  if (type == MapTilerType.Positron) {
    return opts.copy(
      templateUrl:
          'https://api.maptiler.com/maps/positron/{z}/{x}/{y}{r}.png?key=$apikey',
    );
  }

  if (type == MapTilerType.Hybrid) {
    return opts.copy(
      templateUrl:
          'https://api.maptiler.com/maps/hybrid/{z}/{x}/{y}{r}.jpg?key=$apikey',
    );
  }

  if (type == MapTilerType.Toner) {
    return opts.copy(
      templateUrl:
          'https://api.maptiler.com/maps/toner/{z}/{x}/{y}{r}.png?key=$apikey',
    );
  }

  if (type == MapTilerType.Topo) {
    return opts.copy(
      templateUrl:
          'https://api.maptiler.com/maps/topo/{z}/{x}/{y}{r}.png?key=$apikey',
    );
  }

  if (type == MapTilerType.Voyager) {
    return opts.copy(
      templateUrl:
          'https://api.maptiler.com/maps/voyager/{z}/{x}/{y}{r}.png?key=$apikey',
    );
  }

  return opts;
}

TileLayerOptions stamen(StamenType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    subdomains: 'abcd',
    attribution:
        'Map tiles by Stamen Design, CC BY 3.0 &mdash; Map data: &copy; OpenStreetMap contributors',
    maxZoom: 20,
  );

  if (type == StamenType.Toner) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/toner/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == StamenType.TonerBackground) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-background/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == StamenType.TonerHybrid) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-hybrid/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == StamenType.TonerLines) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lines/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == StamenType.TonerLabels) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-labels/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == StamenType.TonerLite) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == StamenType.Watercolor) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.jpg',
      maxZoom: 16,
      minZoom: 1,
    );
  }

  if (type == StamenType.Terrain) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/terrain/{z}/{x}/{y}{r}.png',
      maxZoom: 18,
    );
  }

  if (type == StamenType.TerrainBackground) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/terrain-background/{z}/{x}/{y}{r}.png',
      maxZoom: 18,
    );
  }

  if (type == StamenType.TerrainLabels) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/terrain-labels/{z}/{x}/{y}{r}.png',
      maxZoom: 18,
    );
  }

  if (type == StamenType.TopOSMRelief) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/toposm-color-relief/{z}/{x}/{y}.jpg',
      bounds: [
        [22, -132],
        [51, -56]
      ],
    );
  }

  if (type == StamenType.TopOSMFeatures) {
    return opts.copy(
      templateUrl:
          'https://stamen-tiles-{s}.a.ssl.fastly.net/toposm-features/{z}/{x}/{y}.png',
      bounds: [
        [22, -132],
        [51, -56]
      ],
      opacity: 0.9,
    );
  }

  return opts;
}

TileLayerOptions tomtom(
    TomTomType type, TileLayerOptions options, String apikey) {
  TileLayerOptions opts = options.copy(
    subdomains: 'abcd',
    attribution: '&copy;  1992 - ${DateTime.now().year} TomTom',
    maxZoom: 22,
  );

  if (type == TomTomType.Basic) {
    return opts.copy(
      templateUrl:
          'https://{s}.api.tomtom.com/map/1/tile/basic/main/{z}/{x}/{y}.png?key=$apikey',
    );
  }

  if (type == TomTomType.Hybrid) {
    return opts.copy(
      templateUrl:
          'https://{s}.api.tomtom.com/map/1/tile/hybrid/main/{z}/{x}/{y}.png?key=$apikey',
    );
  }

  if (type == TomTomType.Labels) {
    return opts.copy(
      templateUrl:
          'https://{s}.api.tomtom.com/map/1/tile/labels/main/{z}/{x}/{y}.png?key=$apikey',
    );
  }

  return opts;
}

TileLayerOptions esri(EsriType type, TileLayerOptions options) {
  if (type == EsriType.WorldStreetMap) {
    return options.copy(
      templateUrl:
          'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri',
    );
  }

  if (type == EsriType.DeLorme) {
    return options.copy(
      templateUrl:
          'https://server.arcgisonline.com/ArcGIS/rest/services/Specialty/DeLorme_World_Base_Map/MapServer/tile/{z}/{y}/{x}',
      minZoom: 1,
      maxZoom: 11,
      attribution: 'Tiles &copy; Esri &mdash; Copyright: &copy;2012 DeLorme',
    );
  }

  if (type == EsriType.WorldTopoMap) {
    return options.copy(
      templateUrl:
          'https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}',
      attribution:
          'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ, TomTom, Intermap, iPC, USGS, FAO, NPS, NRCAN, GeoBase, Kadaster NL, Ordnance Survey, Esri Japan, METI, Esri China (Hong Kong), and the GIS User Community',
    );
  }

  if (type == EsriType.WorldImagery) {
    return options.copy(
      templateUrl:
          'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
      attribution:
          'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community',
    );
  }

  if (type == EsriType.WorldTerrain) {
    return options.copy(
      templateUrl:
          'https://server.arcgisonline.com/ArcGIS/rest/services/World_Terrain_Base/MapServer/tile/{z}/{y}/{x}',
      attribution:
          'Tiles &copy; Esri &mdash; Source: USGS, Esri, TANA, DeLorme, and NPS',
      maxZoom: 13,
    );
  }

  if (type == EsriType.WorldShadedRelief) {
    return options.copy(
      templateUrl:
          'https://server.arcgisonline.com/ArcGIS/rest/services/World_Shaded_Relief/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri &mdash; Source: Esri',
      maxZoom: 13,
    );
  }

  if (type == EsriType.WorldPhysical) {
    return options.copy(
      templateUrl:
          'https://server.arcgisonline.com/ArcGIS/rest/services/World_Physical_Map/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri &mdash; Source: US National Park Service',
      maxZoom: 8,
    );
  }

  if (type == EsriType.OceanBasemap) {
    return options.copy(
      templateUrl:
          'https://server.arcgisonline.com/ArcGIS/rest/services/Ocean_Basemap/MapServer/tile/{z}/{y}/{x}',
      attribution:
          'Tiles &copy; Esri &mdash; Sources: GEBCO, NOAA, CHS, OSU, UNH, CSUMB, National Geographic, DeLorme, NAVTEQ, and Esri',
      maxZoom: 13,
    );
  }

  if (type == EsriType.NatGeoWorldMap) {
    return options.copy(
      templateUrl:
          'https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}',
      attribution:
          'Tiles &copy; Esri &mdash; National Geographic, Esri, DeLorme, NAVTEQ, UNEP-WCMC, USGS, NASA, ESA, METI, NRCAN, GEBCO, NOAA, iPC',
      maxZoom: 16,
    );
  }

  if (type == EsriType.WorldGray) {
    return options.copy(
      templateUrl:
          'https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ',
      maxZoom: 16,
    );
  }

  return options;
}

TileLayerOptions cartodb(CartoDBType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    subdomains: 'abcd',
    attribution: 'Map data &copy; OpenStreetMap contributors, &copy; CARTO',
    maxZoom: 19,
  );

  if (type == CartoDBType.Positron) {
    return opts.copy(
      templateUrl:
          'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == CartoDBType.PositronNoLabels) {
    return opts.copy(
      templateUrl:
          'https://{s}.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == CartoDBType.PositronOnlyLabels) {
    return opts.copy(
      templateUrl:
          'https://{s}.basemaps.cartocdn.com/light_only_labels/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == CartoDBType.DarkMatter) {
    return opts.copy(
      templateUrl:
          'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == CartoDBType.DarkMatterNoLabels) {
    return opts.copy(
      templateUrl:
          'https://{s}.basemaps.cartocdn.com/dark_nolabels/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == CartoDBType.DarkMatterOnlyLabels) {
    return opts.copy(
      templateUrl:
          'https://{s}.basemaps.cartocdn.com/dark_only_labels/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == CartoDBType.Voyager) {
    return opts.copy(
      templateUrl:
          'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == CartoDBType.VoyagerNoLabels) {
    return opts.copy(
      templateUrl:
          'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == CartoDBType.VoyagerOnlyLabels) {
    return opts.copy(
      templateUrl:
          'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_only_labels/{z}/{x}/{y}{r}.png',
    );
  }

  if (type == CartoDBType.VoyagerLabelsUnder) {
    return opts.copy(
      templateUrl:
          'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_labels_under/{z}/{x}/{y}{r}.png',
    );
  }

  return opts;
}

TileLayerOptions basemapat(BasemapATType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    subdomains: ['', '1', '2', '3', '4'],
    attribution: 'Datenquelle: basemap.at',
    maxZoom: 19,
    bounds: [
      [46.358770, 8.782379],
      [49.037872, 17.189532]
    ],
  );

  if (type == BasemapATType.Default) {
    return opts.copy(
      templateUrl:
          'https://maps{s}.wien.gv.at/basemap/geolandbasemap/normal/google3857/{z}/{y}/{x}.png',
      maxZoom: 20,
    );
  }

  if (type == BasemapATType.Grau) {
    return opts.copy(
      templateUrl:
          'https://maps{s}.wien.gv.at/basemap/bmapgrau/normal/google3857/{z}/{y}/{x}.png',
    );
  }

  if (type == BasemapATType.Overlay) {
    return opts.copy(
      templateUrl:
          'https://maps{s}.wien.gv.at/basemap/bmapoverlay/normal/google3857/{z}/{y}/{x}.png',
    );
  }

  if (type == BasemapATType.Terrain) {
    return opts.copy(
      templateUrl:
          'https://maps{s}.wien.gv.at/basemap/bmapgelaende/grau/google3857/{z}/{y}/{x}.jpeg',
    );
  }

  if (type == BasemapATType.Surface) {
    return opts.copy(
      templateUrl:
          'https://maps{s}.wien.gv.at/basemap/bmapoberflaeche/grau/google3857/{z}/{y}/{x}.jpeg',
    );
  }

  if (type == BasemapATType.Hdpi) {
    return opts.copy(
      templateUrl:
          'https://maps{s}.wien.gv.at/basemap/bmaphidpi/normal/google3857/{z}/{y}/{x}.jpeg',
    );
  }

  if (type == BasemapATType.Orthofoto) {
    return opts.copy(
      templateUrl:
          'https://maps{s}.wien.gv.at/basemap/bmaporthofoto30cm/normal/google3857/{z}/{y}/{x}.jpeg',
      maxZoom: 20,
    );
  }

  return opts;
}

TileLayerOptions hikebike(HikeBikeType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    attribution: 'Map data &copy; OpenStreetMap contributors',
  );

  if (type == HikeBikeType.Default) {
    return opts.copy(
      templateUrl: 'https://tiles.wmflabs.org/hikebike/{z}/{x}/{y}.png',
      maxZoom: 19,
    );
  }

  if (type == HikeBikeType.Hill) {
    return opts.copy(
      templateUrl: 'https://tiles.wmflabs.org/hillshading/{z}/{x}/{y}.png',
      maxZoom: 15,
    );
  }

  return opts;
}

TileLayerOptions nlmaps(NLMapsType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    attribution: 'Kaartgegevens &copy; Kadaster',
    maxZoom: 19,
    minZoom: 6,
    bounds: [
      [50.5, 3.25],
      [54, 7.6]
    ],
  );

  if (type == NLMapsType.Default) {
    return opts.copy(
      templateUrl:
          'https://geodata.nationaalgeoregister.nl/tiles/service/wmts/brtachtergrondkaart/EPSG:3857/{z}/{x}/{y}.png',
    );
  }

  if (type == NLMapsType.Pastel) {
    return opts.copy(
      templateUrl:
          'https://geodata.nationaalgeoregister.nl/tiles/service/wmts/brtachtergrondkaartpastel/EPSG:3857/{z}/{x}/{y}.png',
    );
  }

  if (type == NLMapsType.Grijs) {
    return opts.copy(
      templateUrl:
          'https://geodata.nationaalgeoregister.nl/tiles/service/wmts/brtachtergrondkaartgrijs/EPSG:3857/{z}/{x}/{y}.png',
    );
  }

  if (type == NLMapsType.Luchtfoto) {
    return opts.copy(
      templateUrl:
          'https://geodata.nationaalgeoregister.nl/luchtfoto/rgb/wmts/2018_ortho25/EPSG:3857/{z}/{x}/{y}.png',
    );
  }

  return opts;
}

// Get your own geoportail apikey here : http://professionnels.ign.fr/ign/contrats/
// NB : 'choisirgeoportail' is a demonstration key that comes with no guarantee
TileLayerOptions geoportail(
    GeoportailFranceType type, TileLayerOptions options, String apikey) {
  TileLayerOptions opts = options.copy(
    attribution: 'Geoportail France',
    minZoom: 2,
    maxZoom: 18,
    bounds: [
      [-75, -180],
      [81, 180]
    ],
  );

  if (type == GeoportailFranceType.Plan) {
    return opts.copy(
      templateUrl:
          'https://wxs.ign.fr/$apikey/geoportail/wmts?REQUEST=GetTile&SERVICE=WMTS&VERSION=1.0.0&STYLE=normal&TILEMATRIXSET=PM&FORMAT=image/png&LAYER=GEOGRAPHICALGRIDSYSTEMS.PLANIGNV2&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}',
    );
  }

  if (type == GeoportailFranceType.Parcels) {
    return opts.copy(
      templateUrl:
          'https://wxs.ign.fr/$apikey/geoportail/wmts?REQUEST=GetTile&SERVICE=WMTS&VERSION=1.0.0&STYLE=PCI vecteur&TILEMATRIXSET=PM&FORMAT=image/png&LAYER=CADASTRALPARCELS.PARCELLAIRE_EXPRESS&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}',
    );
  }

  if (type == GeoportailFranceType.Orthos) {
    return opts.copy(
      templateUrl:
          'https://wxs.ign.fr/$apikey/geoportail/wmts?REQUEST=GetTile&SERVICE=WMTS&VERSION=1.0.0&STYLE=normal&TILEMATRIXSET=PM&FORMAT=image/jpeg&LAYER=ORTHOIMAGERY.ORTHOPHOTOS&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}',
    );
  }

  return opts;
}

TileLayerOptions justice(JusticeMapType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    attribution: 'Justice Map',
    bounds: [
      [14, -180],
      [72, -56]
    ],
  );

  if (type == JusticeMapType.Multi) {
    return opts.copy(
      templateUrl:
          'http://www.justicemap.org/tile/county/multi/{z}/{x}/{y}.png',
    );
  }

  if (type == JusticeMapType.Income) {
    return opts.copy(
      templateUrl:
          'http://www.justicemap.org/tile/county/income/{z}/{x}/{y}.png',
    );
  }

  if (type == JusticeMapType.Indian) {
    return opts.copy(
      templateUrl:
          'http://www.justicemap.org/tile/county/indian/{z}/{x}/{y}.png',
    );
  }

  if (type == JusticeMapType.Asian) {
    return opts.copy(
      templateUrl:
          'http://www.justicemap.org/tile/county/asian/{z}/{x}/{y}.png',
    );
  }

  if (type == JusticeMapType.Black) {
    return opts.copy(
      templateUrl:
          'http://www.justicemap.org/tile/county/black/{z}/{x}/{y}.png',
    );
  }

  if (type == JusticeMapType.Hispanic) {
    return opts.copy(
      templateUrl:
          'http://www.justicemap.org/tile/county/hispanic/{z}/{x}/{y}.png',
    );
  }

  if (type == JusticeMapType.Nonwhite) {
    return opts.copy(
      templateUrl:
          'http://www.justicemap.org/tile/county/nonwhite/{z}/{x}/{y}.png',
    );
  }

  if (type == JusticeMapType.White) {
    return opts.copy(
      templateUrl:
          'http://www.justicemap.org/tile/county/white/{z}/{x}/{y}.png',
    );
  }

  if (type == JusticeMapType.Plural) {
    return opts.copy(
      templateUrl:
          'http://www.justicemap.org/tile/county/plural/{z}/{x}/{y}.png',
    );
  }

  return opts;
}

TileLayerOptions openweather(
    OpenWeatherMapType type, TileLayerOptions options, String apikey) {
  TileLayerOptions opts = options.copy(
    attribution: 'Map data &copy; OpenWeatherMap',
    maxZoom: 19,
    opacity: 0.5,
  );

  if (type == OpenWeatherMapType.Clouds) {
    return opts.copy(
      templateUrl:
          'http://{s}.tile.openweathermap.org/map/clouds/{z}/{x}/{y}.png?appid=$apikey',
    );
  }

  if (type == OpenWeatherMapType.CloudsClassic) {
    return opts.copy(
      templateUrl:
          'http://{s}.tile.openweathermap.org/map/clouds_cls/{z}/{x}/{y}.png?appid=$apikey',
    );
  }

  if (type == OpenWeatherMapType.Precipitation) {
    return opts.copy(
      templateUrl:
          'http://{s}.tile.openweathermap.org/map/precipitation/{z}/{x}/{y}.png?appid=$apikey',
    );
  }

  if (type == OpenWeatherMapType.PrecipitationClassic) {
    return opts.copy(
      templateUrl:
          'http://{s}.tile.openweathermap.org/map/precipitation_cls/{z}/{x}/{y}.png?appid=$apikey',
    );
  }

  if (type == OpenWeatherMapType.Rain) {
    return opts.copy(
      templateUrl:
          'http://{s}.tile.openweathermap.org/map/rain/{z}/{x}/{y}.png?appid=$apikey',
    );
  }

  if (type == OpenWeatherMapType.RainClassic) {
    return opts.copy(
      templateUrl:
          'http://{s}.tile.openweathermap.org/map/rain_cls/{z}/{x}/{y}.png?appid=$apikey',
    );
  }

  if (type == OpenWeatherMapType.Pressure) {
    return opts.copy(
      templateUrl:
          'http://{s}.tile.openweathermap.org/map/pressure/{z}/{x}/{y}.png?appid=$apikey',
    );
  }

  if (type == OpenWeatherMapType.PressureContour) {
    return opts.copy(
      templateUrl:
          'http://{s}.tile.openweathermap.org/map/pressure_cntr/{z}/{x}/{y}.png?appid=$apikey',
    );
  }

  if (type == OpenWeatherMapType.Wind) {
    return opts.copy(
      templateUrl:
          'http://{s}.tile.openweathermap.org/map/wind/{z}/{x}/{y}.png?appid=$apikey',
    );
  }

  if (type == OpenWeatherMapType.Temperature) {
    return opts.copy(
      templateUrl:
          'http://{s}.tile.openweathermap.org/map/temp/{z}/{x}/{y}.png?appid=$apikey',
    );
  }

  if (type == OpenWeatherMapType.Snow) {
    return opts.copy(
      templateUrl:
          'http://{s}.tile.openweathermap.org/map/snow/{z}/{x}/{y}.png?appid=$apikey',
    );
  }

  return opts;
}

TileLayerOptions onemapsg(OneMapSGType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    attribution:
        'New OneMap | Map data &copy; contributors, Singapore Land Authority',
    maxZoom: 18,
    minZoom: 11,
    bounds: [
      [1.56073, 104.11475],
      [1.16, 103.502]
    ],
  );

  if (type == OneMapSGType.Default) {
    return opts.copy(
      templateUrl: 'https://maps-{s}.onemap.sg/v3/Default/{z}/{x}/{y}.png',
    );
  }

  if (type == OneMapSGType.Night) {
    return opts.copy(
      templateUrl: 'https://maps-{s}.onemap.sg/v3/Night/{z}/{x}/{y}.png',
    );
  }

  if (type == OneMapSGType.Original) {
    return opts.copy(
      templateUrl: 'https://maps-{s}.onemap.sg/v3/Original/{z}/{x}/{y}.png',
    );
  }

  if (type == OneMapSGType.Grey) {
    return opts.copy(
      templateUrl: 'https://maps-{s}.onemap.sg/v3/Grey/{z}/{x}/{y}.png',
    );
  }

  if (type == OneMapSGType.LandLot) {
    return opts.copy(
      templateUrl: 'https://maps-{s}.onemap.sg/v3/LandLot/{z}/{x}/{y}.png',
    );
  }

  return opts;
}

TileLayerOptions nasagibs(NASAGIBSType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    attribution:
        'Imagery provided by services from the Global Imagery Browse Services (GIBS), operated by the NASA/GSFC/Earth Science Data and Information System (ESDIS) with funding provided by NASA/HQ.',
    minZoom: 1,
    bounds: [
      [-85.0511287776, -179.999999975],
      [85.0511287776, 179.999999975]
    ],
  );

  if (type == NASAGIBSType.ModisTerraTrueColorCR) {
    return opts.copy(
      templateUrl:
          'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_CorrectedReflectance_TrueColor/default//GoogleMapsCompatible_Level/9/{z}/{y}/{x}.jpg',
      maxZoom: 9,
    );
  }

  if (type == NASAGIBSType.ModisTerraBands367CR) {
    return opts.copy(
      templateUrl:
          'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_CorrectedReflectance_Bands367/default//GoogleMapsCompatible_Level/9/{z}/{y}/{x}.jpg',
      maxZoom: 9,
    );
  }

  if (type == NASAGIBSType.ViirsEarthAtNight2012) {
    return opts.copy(
      templateUrl:
          'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/VIIRS_CityLights_2012/default//GoogleMapsCompatible_Level/8/{z}/{y}/{x}.jpg',
      maxZoom: 8,
    );
  }

  if (type == NASAGIBSType.ModisTerraLSTDay) {
    return opts.copy(
      templateUrl:
          'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Land_Surface_Temp_Day/default//GoogleMapsCompatible_Level/7/{z}/{y}/{x}.png',
      maxZoom: 7,
      opacity: 0.75,
    );
  }

  if (type == NASAGIBSType.ModisTerraSnowCover) {
    return opts.copy(
      templateUrl:
          'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Snow_Cover/default//GoogleMapsCompatible_Level/8/{z}/{y}/{x}.png',
      maxZoom: 8,
      opacity: 0.75,
    );
  }

  if (type == NASAGIBSType.ModisTerraAOD) {
    return opts.copy(
      templateUrl:
          'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Aerosol/default//GoogleMapsCompatible_Level/6/{z}/{y}/{x}.png',
      maxZoom: 6,
    );
  }

  if (type == NASAGIBSType.ModisTerraChlorophyll) {
    return opts.copy(
      templateUrl:
          'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Chlorophyll_A/default//GoogleMapsCompatible_Level/7/{z}/{y}/{x}.png',
      maxZoom: 7,
      opacity: 0.75,
    );
  }

  return opts;
}

TileLayerOptions usgs(USGSType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    attribution: 'Tiles courtesy of the U.S. Geological Survey',
    maxZoom: 20,
  );

  if (type == USGSType.Topo) {
    return opts.copy(
      templateUrl:
          'https://basemap.nationalmap.gov/arcgis/rest/services/USGSTopo/MapServer/tile/{z}/{y}/{x}',
    );
  }

  if (type == USGSType.Imagery) {
    return opts.copy(
      templateUrl:
          'https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryOnly/MapServer/tile/{z}/{y}/{x}',
    );
  }

  if (type == USGSType.ImageryTopo) {
    return opts.copy(
      templateUrl:
          'https://basemap.nationalmap.gov/arcgis/rest/services/USGSImageryTopo/MapServer/tile/{z}/{y}/{x}',
    );
  }

  return opts;
}

TileLayerOptions waymarkedtrails(
    WaymarkedTrailsType type, TileLayerOptions options) {
  TileLayerOptions opts = options.copy(
    attribution:
        '$osmAttrDef | Map style: &copy; waymarkedtrails.org (CC-BY-SA)',
    maxZoom: 18,
  );

  if (type == WaymarkedTrailsType.Hiking) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/hiking/{z}/{x}/{y}.png',
    );
  }

  if (type == WaymarkedTrailsType.Cycling) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/cycling/{z}/{x}/{y}.png',
    );
  }

  if (type == WaymarkedTrailsType.MTB) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/mtb/{z}/{x}/{y}.png',
    );
  }

  if (type == WaymarkedTrailsType.Slopes) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/slopes/{z}/{x}/{y}.png',
    );
  }

  if (type == WaymarkedTrailsType.Riding) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/riding/{z}/{x}/{y}.png',
    );
  }

  if (type == WaymarkedTrailsType.Skating) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/skating/{z}/{x}/{y}.png',
    );
  }

  return options;
}

/*
* HERE maps, formerly Nokia maps.
* These basemaps are free, but you need an api id and app key. Please sign up at
* https://developer.here.com/plans
*/
TileLayerOptions here(
    HereType type, TileLayerOptions options, String appId, String appCode) {
  TileLayerOptions opts = options.copy(
    subdomains: '1234',
    attribution: 'Map &copy; 1987- ${DateTime.now().year} HERE',
    maxZoom: 20,
  );

  if (type == HereType.NormalDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayCustom) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.day.custom/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayGrey) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.day.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.day.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayGreyMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.day.grey.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayTransit) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.day.transit/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayTransitMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.day.transit.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayTraffic) {
    return opts.copy(
        templateUrl:
            'https://{s}.traffic.maps.api.here.com/maptile/2.1/traffictile/newest/normal.traffic.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNight) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.night/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNightMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.night.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNightGrey) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.night.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNightGreyMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.night.grey.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNightTransit) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.night.transit/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNightTransitMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.night.transit.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.ReducedDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/reduced.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.ReducedNight) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/reduced.night/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.BasicMap) {
    return opts.copy(
        templateUrl:
            'https://{s}.basetile.maps.api.here.com/maptile/2.1/maptile/newest//{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.MapLabels) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/labeltile/newest//{z}/{x}/{y}/256/png?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.TrafficFlow) {
    return opts.copy(
        templateUrl:
            'https://{s}.traffic.maps.api.here.com/maptile/2.1/flowtile/newest//{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.CarnavDayGrey) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/carnav.day.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.HybridDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.api.here.com/maptile/2.1/maptile/newest/hybrid.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.HybridDayMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.api.here.com/maptile/2.1/maptile/newest/hybrid.day.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.HybridDayTransit) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.api.here.com/maptile/2.1/maptile/newest/hybrid.day.transit/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.HybridDayGrey) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.api.here.com/maptile/2.1/maptile/newest/hybrid.day.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.HybridDayTraffic) {
    return opts.copy(
        templateUrl:
            'https://{s}.traffic.maps.api.here.com/maptile/2.1/traffictile/newest/hybrid.day.traffic/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.PedestrianDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/pedestrian.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.PedestrianNight) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.api.here.com/maptile/2.1/maptile/newest/pedestrian.night/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.SatelliteDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.api.here.com/maptile/2.1/maptile/newest/satellite.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.TerrainDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.api.here.com/maptile/2.1/maptile/newest/terrain.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.TerrainDayMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.api.here.com/maptile/2.1/maptile/newest/terrain.day.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  return opts;
}

/*
* HERE maps, formerly Nokia maps.
* These basemaps are free, but you need an api id and app key. Please sign up at
* https://developer.here.com/plans
*/
TileLayerOptions herev3(
    HereType type, TileLayerOptions options, String appId, String appCode) {
  TileLayerOptions opts = options.copy(
    subdomains: '1234',
    attribution: 'Map &copy; 1987- ${DateTime.now().year} HERE',
    maxZoom: 20,
  );

  if (type == HereType.NormalDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayCustom) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.custom/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayGrey) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayGreyMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.grey.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayTransit) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.transit/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayTransitMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.transit.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalDayTraffic) {
    return opts.copy(
        templateUrl:
            'https://{s}.traffic.maps.ls.hereapi.com/maptile/2.1/traffictile/newest/normal.traffic.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNight) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNightMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNightGrey) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNightGreyMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night.grey.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNightTransit) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night.transit/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.NormalNightTransitMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night.transit.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.ReducedDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/reduced.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.ReducedNight) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/reduced.night/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.BasicMap) {
    return opts.copy(
        templateUrl:
            'https://{s}.basetile.maps.ls.hereapi.com/maptile/2.1/maptile/newest//{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.MapLabels) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/labeltile/newest//{z}/{x}/{y}/256/png?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.TrafficFlow) {
    return opts.copy(
        templateUrl:
            'https://{s}.traffic.maps.ls.hereapi.com/maptile/2.1/flowtile/newest//{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.CarnavDayGrey) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/carnav.day.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.HybridDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/hybrid.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.HybridDayMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/hybrid.day.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.HybridDayTransit) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/hybrid.day.transit/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.HybridDayGrey) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/hybrid.day.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.HybridDayTraffic) {
    return opts.copy(
        templateUrl:
            'https://{s}.traffic.maps.ls.hereapi.com/maptile/2.1/traffictile/newest/hybrid.day.traffic/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.PedestrianDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/pedestrian.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.PedestrianNight) {
    return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/pedestrian.night/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.SatelliteDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/satellite.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.TerrainDay) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/terrain.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  if (type == HereType.TerrainDayMobile) {
    return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/terrain.day.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng');
  }

  return opts;
}

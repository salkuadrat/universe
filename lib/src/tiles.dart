import 'layer/layer.dart';
import 'type.dart';

TileLayerOptions osm(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = 'Map Data &copy; OpenStreetMap contributors';
  double maxZoom = 18;

  if(type == OpenStreetMapType.Mapnik) {
    return options.copy(
      templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
      attribution: attribution,
      maxZoom: 19,
    );
  } 
  else if(type == OpenStreetMapType.DE) {
    return options.copy(
      templateUrl: 'https://{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png', 
      attribution: attribution,
      maxZoom: maxZoom
    );
  } 
  else if(type == OpenStreetMapType.CH) {
    return options.copy(
      templateUrl: 'https://tile.osm.ch/switzerland/{z}/{x}/{y}.png', 
      bounds: [[45, 5], [48, 11]],
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.France) {
    return options.copy(
      templateUrl: 'https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png', 
			attribution: '&copy; Openstreetmap France | $attribution',
      maxZoom: 20,
    );
  }
  else if(type == OpenStreetMapType.HOT) {
    return options.copy(
      templateUrl: 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png', 
      attribution: '$attribution, Tiles style by Humanitarian OpenStreetMap Team hosted by OpenStreetMap France'
    );
  }
  else if(type == OpenStreetMapType.BZH) {
    return options.copy(
      templateUrl: 'https://tile.openstreetmap.bzh/br/{z}/{x}/{y}.png', 
      attribution: '$attribution, Tiles courtesy of Breton OpenStreetMap Team',
			bounds: [[46.2, -5.5], [50, 0.7]],
    );
  }
  else if(type == OpenStreetMapType.OpenSeaMap) {
    return options.copy(
      templateUrl: 'https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png', 
      attribution: 'Map data: &copy; OpenSeaMap contributors'
    );
  }
  else if(type == OpenStreetMapType.OpenPtMap) {
    return options.copy(
      templateUrl: 'http://openptmap.org/tiles/{z}/{x}/{y}.png', 
      attribution: 'Map data: &copy; OpenPtMap contributors',
      maxZoom: 17,
    );
  }
  else if(type == OpenStreetMapType.OpenTopoMap) {
    return options.copy(
      templateUrl: 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
      attribution: '$attribution, SRTM | Map style: &copy; OpenTopoMap (CC-BY-SA)',
      maxZoom: 17,
    );
  }
  else if(type == OpenStreetMapType.OpenRailwayMap) {
    return options.copy(
      templateUrl: 'https://{s}.tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png',
      attribution: '$attribution | Map style: &copy; OpenRailwayMap (CC-BY-SA)',
      maxZoom: 19,
    );
  }
  else if(type == OpenStreetMapType.OpenFireMap) {
    return options.copy(
      templateUrl: 'http://openfiremap.org/hytiles/{z}/{x}/{y}.png',
      attribution: '$attribution | Map style: &copy; OpenFireMap (CC-BY-SA)',
      maxZoom: 19,
    );
  }
  else if(type == OpenStreetMapType.SafeCast) {
    return options.copy(
      templateUrl: 'https://s3.amazonaws.com/te512.safecast.org/{z}/{x}/{y}.png',
      attribution: '$attribution | Map style: &copy; SafeCast (CC-BY-SA)',
      maxZoom: 19,
    );
  }
  else if(type == OpenStreetMapType.CyclOSM) {
    return options.copy(
      templateUrl: 'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
      attribution: 'CyclOSM | $attribution',
      maxZoom: 20,
    );
  }
  else if(type == OpenStreetMapType.FreeMapSK) {
    return options.copy(
      templateUrl: 'https://{s}.freemap.sk/T/{z}/{x}/{y}.jpeg',
      attribution: '$attribution, vizualization CC-By-SA 2.0 Freemap.sk',
      bounds: [[47.204642, 15.996093], [49.830896, 22.576904]],
      subdomains: 'abcd',
      maxZoom: 16,
      minZoom: 8,
    );
  }
  else if(type == OpenStreetMapType.MtbMap) {
    return options.copy(
      templateUrl: 'http://tile.mtbmap.cz/mtbmap_tiles/{z}/{x}/{y}.png',
      attribution: '$attribution &amp; USGS',
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.NLS) {
    return options.copy(
      templateUrl: 'https://nls-{s}.tileserver.com/nls/{z}/{x}/{y}.jpg',
      attribution: 'National Library of Scotland Historic Maps',
      bounds: [[49.6, -12], [61.7, 3]],
			subdomains: '0123',
			maxZoom: 18,
			minZoom: 1,
    );
  }
  else if(type == OpenStreetMapType.Wikimedia) {
    return options.copy(
      templateUrl: 'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}{r}.png',
      attribution: 'Wikimedia',
      maxZoom: 19,
			minZoom: 1,
    );
  }

  return stadia(type, options, apikey);
}

TileLayerOptions stadia(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = '&copy; Stadia Maps, &copy; OpenMapTiles, &copy; OpenStreetMap contributors';
  double maxZoom = 20;

  if(type == OpenStreetMapType.StadiaAlidadeSmooth) {
    return options.copy(
      templateUrl: 'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.StadiaAlidadeSmoothDark) {
    return options.copy(
      templateUrl: 'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.StadiaOSMBright) {
    return options.copy(
      templateUrl: 'https://tiles.stadiamaps.com/tiles/osm_bright/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.StadiaOSMOutdoors) {
    return options.copy(
      templateUrl: 'https://tiles.stadiamaps.com/tiles/outdoors/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }

  return thunderforest(type, options, apikey);
}

TileLayerOptions thunderforest(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = '&copy; Thunderforest, &copy; OpenStreetMap contributors';
  double maxZoom = 22;

  if(type == OpenStreetMapType.ThunderforestCycle) {
    return options.copy(
      templateUrl: 'https://{s}.tile.thunderforest.com/cycle/{z}/{x}/{y}.png?apikey=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.ThunderforestLandscape) {
    return options.copy(
      templateUrl: 'https://{s}.tile.thunderforest.com/landscape/{z}/{x}/{y}.png?apikey=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.ThunderforestMobileAtlas) {
    return options.copy(
      templateUrl: 'https://{s}.tile.thunderforest.com/mobile-atlas/{z}/{x}/{y}.png?apikey=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.ThunderforestNeighbourhood) {
    return options.copy(
      templateUrl: 'https://{s}.tile.thunderforest.com/neighbourhood/{z}/{x}/{y}.png?apikey=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.ThunderforestOutdoors) {
    return options.copy(
      templateUrl: 'https://{s}.tile.thunderforest.com/outdoors/{z}/{x}/{y}.png?apikey=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.ThunderforestPioneer) {
    return options.copy(
      templateUrl: 'https://{s}.tile.thunderforest.com/pioneer/{z}/{x}/{y}.png?apikey=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.ThunderforestSpinal) {
    return options.copy(
      templateUrl: 'https://{s}.tile.thunderforest.com/spinal-map/{z}/{x}/{y}.png?apikey=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.ThunderforestTransport) {
    return options.copy(
      templateUrl: 'https://{s}.tile.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.ThunderforestTransportDark) {
    return options.copy(
      templateUrl: 'https://{s}.tile.thunderforest.com/transport-dark/{z}/{x}/{y}.png?apikey=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }

  return hydda(type, options, apikey);
}

TileLayerOptions hydda(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = 'Tiles courtesy of OpenStreetMap Sweden &mdash; Map Data &copy; OpenStreetMap contributors';
  double maxZoom = 20;

  if(type == OpenStreetMapType.HyddaFull) {
    return options.copy(
      templateUrl: 'https://{s}.tile.openstreetmap.se/hydda/full/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.HyddaBase) {
    return options.copy(
      templateUrl: 'https://{s}.tile.openstreetmap.se/hydda/base/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.HyddaRoadsLabels) {
    return options.copy(
      templateUrl: 'https://{s}.tile.openstreetmap.se/hydda/roads_and_labels/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }

  return jawg(type, options, apikey);
}

TileLayerOptions jawg(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = '&copy; Jawg Maps, &copy; OpenStreetMap contributors';
	double maxZoom = 22;
	String subdomains = 'abcd';

  if(type == OpenStreetMapType.JawgDark) {
    return options.copy(
      templateUrl: 'https://{s}.tile.jawg.io/jawg-dark/{z}/{x}/{y}{r}.png?access-token=$apikey',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.JawgLight) {
    return options.copy(
      templateUrl: 'https://{s}.tile.jawg.io/jawg-light/{z}/{x}/{y}{r}.png?access-token=$apikey',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.JawgMatrix) {
    return options.copy(
      templateUrl: 'https://{s}.tile.jawg.io/jawg-matrix/{z}/{x}/{y}{r}.png?access-token=$apikey',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.JawgStreets) {
    return options.copy(
      templateUrl: 'https://{s}.tile.jawg.io/jawg-streets/{z}/{x}/{y}{r}.png?access-token=$apikey',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.JawgSunny) {
    return options.copy(
      templateUrl: 'https://{s}.tile.jawg.io/jawg-sunny/{z}/{x}/{y}{r}.png?access-token=$apikey',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.JawgTerrain) {
    return options.copy(
      templateUrl: 'https://{s}.tile.jawg.io/jawg-terrain/{z}/{x}/{y}{r}.png?access-token=$apikey',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }

  return maptiler(type, options, apikey);
}

TileLayerOptions maptiler(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = '&copy; MapTiler, &copy; OpenStreetMap contributors';
  double tileSize = 512;
  double zoomOffset = -1;
	double maxZoom = 21;

  if(type == OpenStreetMapType.MapTiler || type == OpenStreetMapType.MapTilerStreets) {
    return options.copy(
      templateUrl: 'https://api.maptiler.com/maps/streets/{z}/{x}/{y}{r}.png?key=$apikey',
      tileSize: tileSize,
      zoomOffset: zoomOffset,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.MapTilerBasic) {
    return options.copy(
      templateUrl: 'https://api.maptiler.com/maps/basic/{z}/{x}/{y}{r}.png?key=$apikey',
      tileSize: tileSize,
      zoomOffset: zoomOffset,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.MapTilerBright) {
    return options.copy(
      templateUrl: 'https://api.maptiler.com/maps/bright/{z}/{x}/{y}{r}.png?key=$apikey',
      tileSize: tileSize,
      zoomOffset: zoomOffset,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.MapTilerPastel) {
    return options.copy(
      templateUrl: 'https://api.maptiler.com/maps/pastel/{z}/{x}/{y}{r}.png?key=$apikey',
      tileSize: tileSize,
      zoomOffset: zoomOffset,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.MapTilerPositron) {
    return options.copy(
      templateUrl: 'https://api.maptiler.com/maps/positron/{z}/{x}/{y}{r}.png?key=$apikey',
      tileSize: tileSize,
      zoomOffset: zoomOffset,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.MapTilerHybrid) {
    return options.copy(
      templateUrl: 'https://api.maptiler.com/maps/hybrid/{z}/{x}/{y}{r}.jpg?key=$apikey',
      tileSize: tileSize,
      zoomOffset: zoomOffset,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.MapTilerToner) {
    return options.copy(
      templateUrl: 'https://api.maptiler.com/maps/toner/{z}/{x}/{y}{r}.png?key=$apikey',
      tileSize: tileSize,
      zoomOffset: zoomOffset,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.MapTilerTopo) {
    return options.copy(
      templateUrl: 'https://api.maptiler.com/maps/topo/{z}/{x}/{y}{r}.png?key=$apikey',
      tileSize: tileSize,
      zoomOffset: zoomOffset,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.MapTilerVoyager) {
    return options.copy(
      templateUrl: 'https://api.maptiler.com/maps/voyager/{z}/{x}/{y}{r}.png?key=$apikey',
      tileSize: tileSize,
      zoomOffset: zoomOffset,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }

  return stamen(type, options, apikey);
}

TileLayerOptions stamen(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = 'Map tiles by Stamen Design, CC BY 3.0 &mdash; Map data: &copy; OpenStreetMap contributors';
	String subdomains = 'abcd';
  double maxZoom = 20;

  if(type == OpenStreetMapType.StamenToner) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/toner/{z}/{x}/{y}{r}.png',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.StamenTonerBackground) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-background/{z}/{x}/{y}{r}.png',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.StamenTonerHybrid) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-hybrid/{z}/{x}/{y}{r}.png',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.StamenTonerLines) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lines/{z}/{x}/{y}{r}.png',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.StamenTonerLabels) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-labels/{z}/{x}/{y}{r}.png',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.StamenTonerLite) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}{r}.png',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.StamenWatercolor) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.jpg',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: 16,
      minZoom: 1,
    );
  }
  else if(type == OpenStreetMapType.StamenTerrain) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/terrain/{z}/{x}/{y}{r}.png',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: 18,
    );
  }
  else if(type == OpenStreetMapType.StamenTerrainBackground) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/terrain-background/{z}/{x}/{y}{r}.png',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: 18,
    );
  }
  else if(type == OpenStreetMapType.StamenTerrainLabels) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/terrain-labels/{z}/{x}/{y}{r}.png',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: 18,
    );
  }
  else if(type == OpenStreetMapType.StamenTopOSMRelief) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/toposm-color-relief/{z}/{x}/{y}.jpg',
      bounds: [[22, -132], [51, -56]],
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.StamenTopOSMFeatures) {
    return options.copy(
      templateUrl: 'https://stamen-tiles-{s}.a.ssl.fastly.net/toposm-features/{z}/{x}/{y}.png',
      bounds: [[22, -132], [51, -56]],
      subdomains: subdomains,
      attribution: attribution,
      opacity: 0.9,
      maxZoom: maxZoom,
    );
  }

  return tomtom(type, options, apikey);
}

TileLayerOptions tomtom(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String year = DateTime.now().year.toString();
  String attribution = '&copy;  1992 - $year TomTom';
	String subdomains = 'abcd';
  double maxZoom = 22;

  if(type == OpenStreetMapType.TomTomBasic) {
    return options.copy(
      templateUrl: 'https://{s}.api.tomtom.com/map/1/tile/basic/main/{z}/{x}/{y}.png?key=$apikey',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.TomTomHybrid) {
    return options.copy(
      templateUrl: 'https://{s}.api.tomtom.com/map/1/tile/hybrid/main/{z}/{x}/{y}.png?key=$apikey',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.TomTomLabels) {
    return options.copy(
      templateUrl: 'https://{s}.api.tomtom.com/map/1/tile/labels/main/{z}/{x}/{y}.png?key=$apikey',
      subdomains: subdomains,
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }

  return esri(type, options, apikey);
}

TileLayerOptions esri(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = 'Tiles &copy; Esri';

  if(type == OpenStreetMapType.EsriWorldStreetMap) {
    return options.copy(
      templateUrl: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
      attribution: attribution,
    );
  }
  else if(type == OpenStreetMapType.EsriDeLorme) {
    return options.copy(
      templateUrl: 'https://server.arcgisonline.com/ArcGIS/rest/services/Specialty/DeLorme_World_Base_Map/MapServer/tile/{z}/{y}/{x}',
      minZoom: 1, maxZoom: 11,
			attribution: 'Tiles &copy; Esri &mdash; Copyright: &copy;2012 DeLorme',
    );
  }
  else if(type == OpenStreetMapType.EsriWorldTopoMap) {
    return options.copy(
      templateUrl: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ, TomTom, Intermap, iPC, USGS, FAO, NPS, NRCAN, GeoBase, Kadaster NL, Ordnance Survey, Esri Japan, METI, Esri China (Hong Kong), and the GIS User Community',
    );
  }
  else if(type == OpenStreetMapType.EsriWorldImagery) {
    return options.copy(
      templateUrl: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community',
    );
  }
  else if(type == OpenStreetMapType.EsriWorldTerrain) {
    return options.copy(
      templateUrl: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Terrain_Base/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri &mdash; Source: USGS, Esri, TANA, DeLorme, and NPS',
      maxZoom: 13,
    );
  }
  else if(type == OpenStreetMapType.EsriWorldShadedRelief) {
    return options.copy(
      templateUrl: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Shaded_Relief/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri &mdash; Source: Esri',
      maxZoom: 13,
    );
  }
  else if(type == OpenStreetMapType.EsriWorldPhysical) {
    return options.copy(
      templateUrl: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Physical_Map/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri &mdash; Source: US National Park Service',
      maxZoom: 8,
    );
  }
  else if(type == OpenStreetMapType.EsriOceanBasemap) {
    return options.copy(
      templateUrl: 'https://server.arcgisonline.com/ArcGIS/rest/services/Ocean_Basemap/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri &mdash; Sources: GEBCO, NOAA, CHS, OSU, UNH, CSUMB, National Geographic, DeLorme, NAVTEQ, and Esri',
      maxZoom: 13,
    );
  }
  else if(type == OpenStreetMapType.EsriNatGeoWorldMap) {
    return options.copy(
      templateUrl: 'https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri &mdash; National Geographic, Esri, DeLorme, NAVTEQ, UNEP-WCMC, USGS, NASA, ESA, METI, NRCAN, GEBCO, NOAA, iPC',
      maxZoom: 16,
    );
  }
  else if(type == OpenStreetMapType.EsriWorldGray) {
    return options.copy(
      templateUrl: 'https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}',
      attribution: 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ',
      maxZoom: 16,
    );
  }

  return cartodb(type, options, apikey);
}

TileLayerOptions cartodb(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = 'Map data &copy; OpenStreetMap contributors, &copy; CARTO';
  String subdomains = 'abcd';
  double maxZoom = 19;

  if(type == OpenStreetMapType.CartoDB || type == OpenStreetMapType.CartoDBPositron) {
    return options.copy(
      templateUrl: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      subdomains: subdomains,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.CartoDBPositronNoLabels) {
    return options.copy(
      templateUrl: 'https://{s}.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      subdomains: subdomains,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.CartoDBPositronOnlyLabels) {
    return options.copy(
      templateUrl: 'https://{s}.basemaps.cartocdn.com/light_only_labels/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      subdomains: subdomains,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.CartoDBDarkMatter) {
    return options.copy(
      templateUrl: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      subdomains: subdomains,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.CartoDBDarkMatterNoLabels) {
    return options.copy(
      templateUrl: 'https://{s}.basemaps.cartocdn.com/dark_nolabels/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      subdomains: subdomains,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.CartoDBDarkMatterOnlyLabels) {
    return options.copy(
      templateUrl: 'https://{s}.basemaps.cartocdn.com/dark_only_labels/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      subdomains: subdomains,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.CartoDBVoyager) {
    return options.copy(
      templateUrl: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      subdomains: subdomains,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.CartoDBVoyagerNoLabels) {
    return options.copy(
      templateUrl: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      subdomains: subdomains,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.CartoDBVoyagerOnlyLabels) {
    return options.copy(
      templateUrl: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_only_labels/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      subdomains: subdomains,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.CartoDBVoyagerLabelsUnder) {
    return options.copy(
      templateUrl: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_labels_under/{z}/{x}/{y}{r}.png',
      attribution: attribution,
      subdomains: subdomains,
      maxZoom: maxZoom,
    );
  }

  return basemapat(type, options, apikey);
}

TileLayerOptions basemapat(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  dynamic bounds = [[46.358770, 8.782379], [49.037872, 17.189532]];
  String attribution = 'Datenquelle: basemap.at';
  List subdomains = ['', '1', '2', '3', '4'];
  double maxZoom = 19;

  if(type == OpenStreetMapType.BasemapAT) {
    return options.copy(
      templateUrl: 'https://maps{s}.wien.gv.at/basemap/geolandbasemap/normal/google3857/{z}/{y}/{x}.png',
      attribution: attribution,
      subdomains: subdomains,
      bounds: bounds,
      maxZoom: 20,
    );
  }
  else if(type == OpenStreetMapType.BasemapATGrau) {
    return options.copy(
      templateUrl: 'https://maps{s}.wien.gv.at/basemap/bmapgrau/normal/google3857/{z}/{y}/{x}.png',
      attribution: attribution,
      subdomains: subdomains,
      bounds: bounds,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.BasemapATOverlay) {
    return options.copy(
      templateUrl: 'https://maps{s}.wien.gv.at/basemap/bmapoverlay/normal/google3857/{z}/{y}/{x}.png',
      attribution: attribution,
      subdomains: subdomains,
      bounds: bounds,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.BasemapATTerrain) {
    return options.copy(
      templateUrl: 'https://maps{s}.wien.gv.at/basemap/bmapgelaende/grau/google3857/{z}/{y}/{x}.jpeg',
      attribution: attribution,
      subdomains: subdomains,
      bounds: bounds,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.BasemapATSurface) {
    return options.copy(
      templateUrl: 'https://maps{s}.wien.gv.at/basemap/bmapoberflaeche/grau/google3857/{z}/{y}/{x}.jpeg',
      attribution: attribution,
      subdomains: subdomains,
      bounds: bounds,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.BasemapATHdpi) {
    return options.copy(
      templateUrl: 'https://maps{s}.wien.gv.at/basemap/bmaphidpi/normal/google3857/{z}/{y}/{x}.jpeg',
      attribution: attribution,
      subdomains: subdomains,
      bounds: bounds,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.BasemapATOrthofoto) {
    return options.copy(
      templateUrl: 'https://maps{s}.wien.gv.at/basemap/bmaporthofoto30cm/normal/google3857/{z}/{y}/{x}.jpeg',
      attribution: attribution,
      subdomains: subdomains,
      bounds: bounds,
      maxZoom: 20,
    );
  }

  return nlmaps(type, options, apikey);
}

TileLayerOptions nlmaps(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = 'Kaartgegevens &copy; Kadaster';
  dynamic bounds = [[50.5, 3.25], [54, 7.6]];
  double maxZoom = 19;
  double minZoom = 6;

  if(type == OpenStreetMapType.NLMaps) {
    return options.copy(
      templateUrl: 'https://geodata.nationaalgeoregister.nl/tiles/service/wmts/brtachtergrondkaart/EPSG:3857/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
      minZoom: minZoom,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.NLMapsPastel) {
    return options.copy(
      templateUrl: 'https://geodata.nationaalgeoregister.nl/tiles/service/wmts/brtachtergrondkaartpastel/EPSG:3857/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
      minZoom: minZoom,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.NLMapsGrijs) {
    return options.copy(
      templateUrl: 'https://geodata.nationaalgeoregister.nl/tiles/service/wmts/brtachtergrondkaartgrijs/EPSG:3857/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
      minZoom: minZoom,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.NLMapsLuchfoto) {
    return options.copy(
      templateUrl: 'https://geodata.nationaalgeoregister.nl/luchtfoto/rgb/wmts/2018_ortho25/EPSG:3857/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
      minZoom: minZoom,
      bounds: bounds,
    );
  }

  return onemapsg(type, options, apikey);
}

TileLayerOptions onemapsg(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = 'New OneMap | Map data &copy; contributors, Singapore Land Authority';
  dynamic bounds = [[1.56073, 104.11475], [1.16, 103.502]];
  double maxZoom = 18;
  double minZoom = 11;

  if(type == OpenStreetMapType.OneMapSG) {
    return options.copy(
      templateUrl: 'https://maps-{s}.onemap.sg/v3/Default/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
      minZoom: minZoom,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.OneMapSGNight) {
    return options.copy(
      templateUrl: 'https://maps-{s}.onemap.sg/v3/Night/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
      minZoom: minZoom,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.OneMapSGOriginal) {
    return options.copy(
      templateUrl: 'https://maps-{s}.onemap.sg/v3/Original/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
      minZoom: minZoom,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.OneMapSGGrey) {
    return options.copy(
      templateUrl: 'https://maps-{s}.onemap.sg/v3/Grey/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
      minZoom: minZoom,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.OneMapSGLandLot) {
    return options.copy(
      templateUrl: 'https://maps-{s}.onemap.sg/v3/LandLot/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
      minZoom: minZoom,
      bounds: bounds,
    );
  }

  return nasagibs(type, options, apikey);
}

TileLayerOptions nasagibs(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = 'Imagery provided by services from the Global Imagery Browse Services (GIBS), operated by the NASA/GSFC/Earth Science Data and Information System (ESDIS) with funding provided by NASA/HQ.';
  dynamic bounds = [[-85.0511287776, -179.999999975], [85.0511287776, 179.999999975]];
  double maxZoom = 9;
  double minZoom = 1;

  if(type == OpenStreetMapType.NASAGIBS || type == OpenStreetMapType.NASAGIBSModisTerraTrueColorCR) {
    return options.copy(
      templateUrl: 'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_CorrectedReflectance_TrueColor/default//GoogleMapsCompatible_Level/$maxZoom/{z}/{y}/{x}.jpg',
      attribution: attribution,
      maxZoom: maxZoom,
      minZoom: minZoom,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.NASAGIBSModisTerraBands367CR) {
    return options.copy(
      templateUrl: 'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_CorrectedReflectance_Bands367/default//GoogleMapsCompatible_Level/$maxZoom/{z}/{y}/{x}.jpg',
      attribution: attribution,
      maxZoom: maxZoom,
      minZoom: minZoom,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.NASAGIBSViirsEarthAtNight2012) {
    return options.copy(
      templateUrl: 'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/VIIRS_CityLights_2012/default//GoogleMapsCompatible_Level/8/{z}/{y}/{x}.jpg',
      attribution: attribution,
      maxZoom: 8,
      minZoom: minZoom,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.NASAGIBSModisTerraLSTDay) {
    return options.copy(
      templateUrl: 'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Land_Surface_Temp_Day/default//GoogleMapsCompatible_Level/7/{z}/{y}/{x}.png',
      attribution: attribution,
      maxZoom: 7,
      minZoom: minZoom,
      bounds: bounds,
      opacity: 0.75,
    );
  }
  else if(type == OpenStreetMapType.NASAGIBSModisTerraSnowCover) {
    return options.copy(
      templateUrl: 'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Snow_Cover/default//GoogleMapsCompatible_Level/8/{z}/{y}/{x}.png',
      attribution: attribution,
      maxZoom: 8,
      minZoom: minZoom,
      bounds: bounds,
      opacity: 0.75,
    );
  }
  else if(type == OpenStreetMapType.NASAGIBSModisTerraAOD) {
    return options.copy(
      templateUrl: 'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Aerosol/default//GoogleMapsCompatible_Level/6/{z}/{y}/{x}.png',
      attribution: attribution,
      maxZoom: 6,
      minZoom: minZoom,
      bounds: bounds,
      opacity: 0.75,
    );
  }
  else if(type == OpenStreetMapType.NASAGIBSModisTerraChlorophyll) {
    return options.copy(
      templateUrl: 'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Chlorophyll_A/default//GoogleMapsCompatible_Level/7/{z}/{y}/{x}.png',
      attribution: attribution,
      maxZoom: 7,
      minZoom: minZoom,
      bounds: bounds,
      opacity: 0.75,
    );
  }

  return hikebike(type, options, apikey);
}

TileLayerOptions hikebike(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = 'Map data &copy; OpenStreetMap contributors';
  double maxZoom = 19;

  if(type == OpenStreetMapType.HikeBike) {
    return options.copy(
      templateUrl: 'https://tiles.wmflabs.org/hikebike/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }
  else if(type == OpenStreetMapType.HikeBikeHill) {
    return options.copy(
      templateUrl: 'https://tiles.wmflabs.org/hillshading/{z}/{x}/{y}.png',
      attribution: attribution,
      maxZoom: maxZoom,
    );
  }

  return openweather(type, options, apikey);
}

TileLayerOptions openweather(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = 'Map data &copy; OpenWeatherMap';
  double maxZoom = 19;
  double opacity = 0.5;

  if(type == OpenStreetMapType.OpenWeatherMap || type == OpenStreetMapType.OpenWeatherMapClouds) {
    return options.copy(
      templateUrl: 'http://{s}.tile.openweathermap.org/map/clouds/{z}/{x}/{y}.png?appid=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
      opacity: opacity,
    );
  }
  else if(type == OpenStreetMapType.OpenWeatherMapCloudsClassic) {
    return options.copy(
      templateUrl: 'http://{s}.tile.openweathermap.org/map/clouds_cls/{z}/{x}/{y}.png?appid=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
      opacity: opacity,
    );
  }
  else if(type == OpenStreetMapType.OpenWeatherMapPrecipitation) {
    return options.copy(
      templateUrl: 'http://{s}.tile.openweathermap.org/map/precipitation/{z}/{x}/{y}.png?appid=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
      opacity: opacity,
    );
  }
  else if(type == OpenStreetMapType.OpenWeatherMapPrecipitationClassic) {
    return options.copy(
      templateUrl: 'http://{s}.tile.openweathermap.org/map/precipitation_cls/{z}/{x}/{y}.png?appid=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
      opacity: opacity,
    );
  }
  else if(type == OpenStreetMapType.OpenWeatherMapRain) {
    return options.copy(
      templateUrl: 'http://{s}.tile.openweathermap.org/map/rain/{z}/{x}/{y}.png?appid=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
      opacity: opacity,
    );
  }
  else if(type == OpenStreetMapType.OpenWeatherMapRainClassic) {
    return options.copy(
      templateUrl: 'http://{s}.tile.openweathermap.org/map/rain_cls/{z}/{x}/{y}.png?appid=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
      opacity: opacity,
    );
  }
  else if(type == OpenStreetMapType.OpenWeatherMapPressure) {
    return options.copy(
      templateUrl: 'http://{s}.tile.openweathermap.org/map/pressure/{z}/{x}/{y}.png?appid=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
      opacity: opacity,
    );
  }
  else if(type == OpenStreetMapType.OpenWeatherMapPressureContour) {
    return options.copy(
      templateUrl: 'http://{s}.tile.openweathermap.org/map/pressure_cntr/{z}/{x}/{y}.png?appid=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
      opacity: opacity,
    );
  }
  else if(type == OpenStreetMapType.OpenWeatherMapWind) {
    return options.copy(
      templateUrl: 'http://{s}.tile.openweathermap.org/map/wind/{z}/{x}/{y}.png?appid=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
      opacity: opacity,
    );
  }
  else if(type == OpenStreetMapType.OpenWeatherMapTemperature) {
    return options.copy(
      templateUrl: 'http://{s}.tile.openweathermap.org/map/temp/{z}/{x}/{y}.png?appid=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
      opacity: opacity,
    );
  }
  else if(type == OpenStreetMapType.OpenWeatherMapSnow) {
    return options.copy(
      templateUrl: 'http://{s}.tile.openweathermap.org/map/snow/{z}/{x}/{y}.png?appid=$apikey',
      attribution: attribution,
      maxZoom: maxZoom,
      opacity: opacity,
    );
  }

  return justice(type, options, apikey);
}

TileLayerOptions justice(OpenStreetMapType type, TileLayerOptions options, String apikey) {
  String attribution = 'Justice Map';
  dynamic bounds = [[14, -180], [72, -56]];
  
  if(type == OpenStreetMapType.JusticeMap || type == OpenStreetMapType.JusticeMapMulti) {
    return options.copy(
      templateUrl: 'http://www.justicemap.org/tile/county/multi/{z}/{x}/{y}.png',
      attribution: attribution,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.JusticeMapIncome) {
    return options.copy(
      templateUrl: 'http://www.justicemap.org/tile/county/income/{z}/{x}/{y}.png',
      attribution: attribution,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.JusticeMapIndian) {
    return options.copy(
      templateUrl: 'http://www.justicemap.org/tile/county/indian/{z}/{x}/{y}.png',
      attribution: attribution,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.JusticeMapAsian) {
    return options.copy(
      templateUrl: 'http://www.justicemap.org/tile/county/asian/{z}/{x}/{y}.png',
      attribution: attribution,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.JusticeMapBlack) {
    return options.copy(
      templateUrl: 'http://www.justicemap.org/tile/county/black/{z}/{x}/{y}.png',
      attribution: attribution,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.JusticeMapHispanic) {
    return options.copy(
      templateUrl: 'http://www.justicemap.org/tile/county/hispanic/{z}/{x}/{y}.png',
      attribution: attribution,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.JusticeMapNonwhite) {
    return options.copy(
      templateUrl: 'http://www.justicemap.org/tile/county/nonwhite/{z}/{x}/{y}.png',
      attribution: attribution,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.JusticeMapWhite) {
    return options.copy(
      templateUrl: 'http://www.justicemap.org/tile/county/white/{z}/{x}/{y}.png',
      attribution: attribution,
      bounds: bounds,
    );
  }
  else if(type == OpenStreetMapType.JusticeMapPlural) {
    return options.copy(
      templateUrl: 'http://www.justicemap.org/tile/county/plural/{z}/{x}/{y}.png',
      attribution: attribution,
      bounds: bounds,
    );
  }
  
  return options;
}
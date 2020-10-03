import 'layer/layer.dart';

TileLayerOptions osm(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions stadia(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions thunderforest(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions hydda(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions jawg(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions stamen(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions tomtom(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions esri(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions carto(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions hikebike(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions basemap(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions nlmaps(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions nasagibs(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

TileLayerOptions justice(OpenStreetMapType type, TileLayerOptions options) {
  return options.copy(
    templateUrl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  );
}

enum OpenStreetMapType {
  Mapnik,
  DE,
  CH,
  France,
  HOT,
  BZH,
  Topo,
  Bright,
  Outdoors,
  StadiaAlidadeSmooth,
  StadiaAlidadeSmoothDark,
  ThunderforestCycle,
  ThunderforestTransport,
  ThunderforestTransportDark,
  ThunderforestSpinal,
  ThunderforestLandscape,
  ThunderforestOutdoors,
  ThunderforestPioneer,
  ThunderforestMobileAtlas,
  ThunderforestNeighbourhood,
  CyclOSM,
  HyddaBase,
  HyddaFull,
  JawgStreets,
  JawgTerrain,
  JawgSunny,
  JawgDark,
  JawgLight,
  JawgMatrix,
  StamenToner,
  StamenTonerBackground,
  StamenTonerLite,
  StamenWatercolor,
  StamenTerrain,
  StamenTerrainBackground,
  StamenTerrainLabels,
  StamenRelief,
  TomTomBasic,
  TomTomHybrid,
  TomTomLabels,
  EsriWorldStreetMap,
  EsriDeLorme,
  EsriWorldTopoMap,
  EsriWorldTerrain,
  EsriWorldShadedRelief,
  EsriWorldPhysical,
  EsriOceanBasemap,
  EsriNatGeoWorldMap,
  EsriWorldGray,
  FreeMapSK,
  MtbMap,
  CartoDBPositron,
  CartoDBPositronNoLabels,
  CartoDBPositronOnlyLabels,
  CartoDBDarkMatter,
  CartoDBDarkMatterNoLabels,
  CartoDBDarkMatterOnlyLabels,
  CartoDBVoyager,
  CartoDBVoyagerNoLabels,
  CartoDBVoyagerOnlyLabels,
  CartoDBVoyagerLabelsUnder,
  HikeBike,
  HikeBikeHill,
  BasemapAT,
  BasemapATGrau,
  BasemapATOverlay,
  BasemapATTerrain,
  BasemapATSurface,
  BasemapATHdpi,
  BasemapATOrthofoto,
  GeoportailFrance,
  GeoportailFranceParcels,
  GeoportailFranceIGN,
  GeoportailFranceOrthos,
  JusticeMap,
  JusticeMapIncome,
  JusticeMapIndian,
  JusticeMapAsian,
  JusticeMapBlack,
  JusticeMapHispanic,
  JusticeMapMulti,
  JusticeMapNonwhite,
  JusticeMapWhite,
  JusticeMapPlural,
  OneMapSG,
  NASAGIBS,
  NASAGIBSModisTerraTrueColorCR,
  NASAGIBSModisTerraBands367CR,
  NASAGIBSViirsEarthAtNight2012,
  NASAGIBSModisTerraLSTDay,
  NASAGIBSModisTerraSnowCover,
  NASAGIBSModisTerraAOD,
  NASAGIBSModisTerraChlorophyll,
  NLMaps,
  NLMapsPastel,
  NLMapsGrijs,
  NLMapsLuchfoto,
  NLS,
  Wikimedia,
}
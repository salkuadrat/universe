import '../layer/layer.dart';
import '../type.dart';

/// Mapping EsriType to its template URL.
TileLayerOptions esri({
  required EsriType type,
  required TileLayerOptions options,
}) {
  switch (type) {
    case EsriType.WorldStreetMap:
      return options.copy(
        templateUrl:
            'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
        attribution: 'Tiles &copy; Esri',
      );
    case EsriType.DeLorme:
      return options.copy(
        templateUrl:
            'https://server.arcgisonline.com/ArcGIS/rest/services/Specialty/DeLorme_World_Base_Map/MapServer/tile/{z}/{y}/{x}',
        minZoom: 1,
        maxZoom: 11,
        attribution: 'Tiles &copy; Esri &mdash; Copyright: &copy;2012 DeLorme',
      );
    case EsriType.WorldTopoMap:
      return options.copy(
        templateUrl:
            'https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}',
        attribution:
            'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ, TomTom, Intermap, iPC, USGS, FAO, NPS, NRCAN, GeoBase, Kadaster NL, Ordnance Survey, Esri Japan, METI, Esri China (Hong Kong), and the GIS User Community',
      );
    case EsriType.WorldImagery:
      return options.copy(
        templateUrl:
            'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
        attribution:
            'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community',
      );
    case EsriType.WorldTerrain:
      return options.copy(
        templateUrl:
            'https://server.arcgisonline.com/ArcGIS/rest/services/World_Terrain_Base/MapServer/tile/{z}/{y}/{x}',
        attribution:
            'Tiles &copy; Esri &mdash; Source: USGS, Esri, TANA, DeLorme, and NPS',
        maxZoom: 13,
      );
    case EsriType.WorldShadedRelief:
      return options.copy(
        templateUrl:
            'https://server.arcgisonline.com/ArcGIS/rest/services/World_Shaded_Relief/MapServer/tile/{z}/{y}/{x}',
        attribution: 'Tiles &copy; Esri &mdash; Source: Esri',
        maxZoom: 13,
      );
    case EsriType.WorldPhysical:
      return options.copy(
        templateUrl:
            'https://server.arcgisonline.com/ArcGIS/rest/services/World_Physical_Map/MapServer/tile/{z}/{y}/{x}',
        attribution:
            'Tiles &copy; Esri &mdash; Source: US National Park Service',
        maxZoom: 8,
      );
    case EsriType.OceanBasemap:
      return options.copy(
        templateUrl:
            'https://server.arcgisonline.com/ArcGIS/rest/services/Ocean_Basemap/MapServer/tile/{z}/{y}/{x}',
        attribution:
            'Tiles &copy; Esri &mdash; Sources: GEBCO, NOAA, CHS, OSU, UNH, CSUMB, National Geographic, DeLorme, NAVTEQ, and Esri',
        maxZoom: 13,
      );
    case EsriType.NatGeoWorldMap:
      return options.copy(
        templateUrl:
            'https://server.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}',
        attribution:
            'Tiles &copy; Esri &mdash; National Geographic, Esri, DeLorme, NAVTEQ, UNEP-WCMC, USGS, NASA, ESA, METI, NRCAN, GEBCO, NOAA, iPC',
        maxZoom: 16,
      );
    case EsriType.WorldGray:
      return options.copy(
        templateUrl:
            'https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}',
        attribution: 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ',
        maxZoom: 16,
      );
  }
}

import '../layer/layer.dart';
import '../type.dart';

/// Mapping NASAGIBSType to its template URL.
TileLayerOptions nasagibs({
  required NASAGIBSType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    attribution:
        'Imagery provided by services from the Global Imagery Browse Services (GIBS), operated by the NASA/GSFC/Earth Science Data and Information System (ESDIS) with funding provided by NASA/HQ.',
    minZoom: 1,
    bounds: [
      [-85.0511287776, -179.999999975],
      [85.0511287776, 179.999999975]
    ],
  );

  switch (type) {
    case NASAGIBSType.ModisTerraTrueColorCR:
      return opts.copy(
        templateUrl:
            'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_CorrectedReflectance_TrueColor/default//GoogleMapsCompatible_Level9/{z}/{y}/{x}.jpg',
        maxZoom: 9,
      );
    case NASAGIBSType.ModisTerraBands367CR:
      return opts.copy(
        templateUrl:
            'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_CorrectedReflectance_Bands367/default//GoogleMapsCompatible_Level9/{z}/{y}/{x}.jpg',
        maxZoom: 9,
      );
    case NASAGIBSType.ViirsEarthAtNight2012:
      return opts.copy(
        templateUrl:
            'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/VIIRS_CityLights_2012/default//GoogleMapsCompatible_Level8/{z}/{y}/{x}.jpg',
        maxZoom: 8,
      );
    case NASAGIBSType.ModisTerraLSTDay:
      return opts.copy(
        templateUrl:
            'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Land_Surface_Temp_Day/default//GoogleMapsCompatible_Level7/{z}/{y}/{x}.png',
        maxZoom: 7,
        opacity: 0.75,
      );
    case NASAGIBSType.ModisTerraSnowCover:
      return opts.copy(
        templateUrl:
            'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Snow_Cover/default//GoogleMapsCompatible_Level8/{z}/{y}/{x}.png',
        maxZoom: 8,
        opacity: 0.75,
      );
    case NASAGIBSType.ModisTerraAOD:
      return opts.copy(
        templateUrl:
            'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Aerosol/default//GoogleMapsCompatible_Level6/{z}/{y}/{x}.png',
        maxZoom: 6,
      );
    case NASAGIBSType.ModisTerraChlorophyll:
      return opts.copy(
        templateUrl:
            'https://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_Chlorophyll_A/default//GoogleMapsCompatible_Level7/{z}/{y}/{x}.png',
        maxZoom: 7,
        opacity: 0.75,
      );
  }
}

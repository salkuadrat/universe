import '../layer/layer.dart';
import '../type.dart';

/// Mapping HereType version 3 to its template URL.
TileLayerOptions herev3({
  required String appId,
  required String appCode,
  required HereType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    subdomains: '1234',
    attribution: 'Map &copy; 1987- ${DateTime.now().year} HERE',
    maxZoom: 20,
  );

  switch (type) {
    case HereType.NormalDay:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalDayCustom:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.custom/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalDayGrey:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalDayMobile:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalDayGreyMobile:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.grey.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalDayTransit:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.transit/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalDayTransitMobile:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.day.transit.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalDayTraffic:
      return opts.copy(
        templateUrl:
            'https://{s}.traffic.maps.ls.hereapi.com/maptile/2.1/traffictile/newest/normal.traffic.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalNight:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalNightMobile:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalNightGrey:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalNightGreyMobile:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night.grey.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalNightTransit:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night.transit/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.NormalNightTransitMobile:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/normal.night.transit.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.ReducedDay:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/reduced.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.ReducedNight:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/reduced.night/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.BasicMap:
      return opts.copy(
        templateUrl:
            'https://{s}.basetile.maps.ls.hereapi.com/maptile/2.1/maptile/newest//{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.MapLabels:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/labeltile/newest//{z}/{x}/{y}/256/png?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.TrafficFlow:
      return opts.copy(
        templateUrl:
            'https://{s}.traffic.maps.ls.hereapi.com/maptile/2.1/flowtile/newest//{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.CarnavDayGrey:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/carnav.day.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.HybridDay:
      return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/hybrid.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.HybridDayMobile:
      return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/hybrid.day.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.HybridDayTransit:
      return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/hybrid.day.transit/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.HybridDayGrey:
      return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/hybrid.day.grey/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.HybridDayTraffic:
      return opts.copy(
        templateUrl:
            'https://{s}.traffic.maps.ls.hereapi.com/maptile/2.1/traffictile/newest/hybrid.day.traffic/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.PedestrianDay:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/pedestrian.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.PedestrianNight:
      return opts.copy(
        templateUrl:
            'https://{s}.base.maps.ls.hereapi.com/maptile/2.1/maptile/newest/pedestrian.night/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.SatelliteDay:
      return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/satellite.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.TerrainDay:
      return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/terrain.day/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
    case HereType.TerrainDayMobile:
      return opts.copy(
        templateUrl:
            'https://{s}.aerial.maps.ls.hereapi.com/maptile/2.1/maptile/newest/terrain.day.mobile/{z}/{x}/{y}/256/png8?app_id=$appId&app_code=$appCode&lg=eng',
      );
  }
}

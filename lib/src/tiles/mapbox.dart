import '../layer/layer.dart';
import '../type.dart';

/// Mapping MapBoxType to its template URL.
TileLayerOptions mapbox({
  required MapBoxType type,
  required String accessToken,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    tileSize: 512,
    maxZoom: 18,
    zoomOffset: -1,
    attribution:
        'Map data &copy; OpenStreetMap contributors, Imagery &copy; MapBox',
  );

  switch (type) {
    case MapBoxType.Basic:
      return opts.copy(
        templateUrl:
            'https://api.mapbox.com/styles/v1/mapbox/basic-v9/tiles/{z}/{x}/{y}?access_token=$accessToken',
      );
    case MapBoxType.Street:
      return opts.copy(
        templateUrl:
            'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=$accessToken',
      );
    case MapBoxType.Satellite:
      return opts.copy(
        templateUrl:
            'https://api.mapbox.com/styles/v1/mapbox/satellite-v9/tiles/{z}/{x}/{y}?access_token=$accessToken',
      );
    case MapBoxType.Hybrid:
      return opts.copy(
        templateUrl:
            'https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v11/tiles/{z}/{x}/{y}?access_token=$accessToken',
      );
    case MapBoxType.Outdoors:
      return opts.copy(
        templateUrl:
            'https://api.mapbox.com/styles/v1/mapbox/outdoors-v11/tiles/{z}/{x}/{y}?access_token=$accessToken',
      );
    case MapBoxType.Light:
      return opts.copy(
        templateUrl:
            'https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/{z}/{x}/{y}?access_token=$accessToken',
      );
    case MapBoxType.Bright:
      return opts.copy(
        templateUrl:
            'https://api.mapbox.com/styles/v1/mapbox/bright-v9/tiles/{z}/{x}/{y}?access_token=$accessToken',
      );
    case MapBoxType.Dark:
      return opts.copy(
        templateUrl:
            'https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/{z}/{x}/{y}?access_token=$accessToken',
      );
  }
}

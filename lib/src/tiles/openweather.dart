import '../layer/layer.dart';
import '../type.dart';

/// Mapping OpenWeatherMapType to its template URL.
TileLayerOptions openweather({
  required String apikey,
  required OpenWeatherMapType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    attribution: 'Map data &copy; OpenWeatherMap',
    maxZoom: 19,
    opacity: 0.5,
  );

  switch (type) {
    case OpenWeatherMapType.Clouds:
      return opts.copy(
        templateUrl:
            'https://{s}.sat.owm.io/vane/2.0/weather/CL/{z}/{x}/{y}?appid=$apikey',
      );
    case OpenWeatherMapType.GlobalPrecipitation:
      return opts.copy(
        templateUrl:
            'https://{s}.sat.owm.io/maps/2.0/radar/{z}/{x}/{y}?appid=$apikey&day=',
      );
    case OpenWeatherMapType.Pressure:
      return opts.copy(
        templateUrl:
            'https://{s}.sat.owm.io/vane/2.0/weather/APM/{z}/{x}/{y}?appid=$apikey',
      );
    case OpenWeatherMapType.Temperature:
      return opts.copy(
        templateUrl:
            'https://{s}.sat.owm.io/vane/2.0/weather/TA2/{z}/{x}/{y}?appid=$apikey',
      );
    case OpenWeatherMapType.WindSpeed:
      return opts.copy(
        templateUrl:
            'https://{s}.sat.owm.io/vane/2.0/weather/WS10/{z}/{x}/{y}?appid=$apikey',
      );
  }
}

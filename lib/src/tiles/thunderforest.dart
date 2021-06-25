import '../layer/layer.dart';
import '../type.dart';

/// Mapping ThunderforestType to its template URL.
TileLayerOptions thunderforest({
  required String apikey,
  required ThunderforestType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    attribution: '&copy; Thunderforest, &copy; OpenStreetMap contributors',
    maxZoom: 22,
  );

  switch (type) {
    case ThunderforestType.Cycle:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.thunderforest.com/cycle/{z}/{x}/{y}.png?apikey=$apikey',
      );
    case ThunderforestType.Landscape:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.thunderforest.com/landscape/{z}/{x}/{y}.png?apikey=$apikey',
      );
    case ThunderforestType.Outdoors:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.thunderforest.com/outdoors/{z}/{x}/{y}.png?apikey=$apikey',
      );
    case ThunderforestType.MobileAtlas:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.thunderforest.com/mobile-atlas/{z}/{x}/{y}.png?apikey=$apikey',
      );
    case ThunderforestType.Neighbourhood:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.thunderforest.com/neighbourhood/{z}/{x}/{y}.png?apikey=$apikey',
      );
    case ThunderforestType.Pioneer:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.thunderforest.com/pioneer/{z}/{x}/{y}.png?apikey=$apikey',
      );
    case ThunderforestType.Spinal:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.thunderforest.com/spinal-map/{z}/{x}/{y}.png?apikey=$apikey',
      );
    case ThunderforestType.Transport:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=$apikey',
      );
    case ThunderforestType.TransportDark:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.thunderforest.com/transport-dark/{z}/{x}/{y}.png?apikey=$apikey',
      );
  }
}

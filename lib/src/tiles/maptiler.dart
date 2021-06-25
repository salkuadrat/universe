import '../layer/layer.dart';
import '../type.dart';

/// Mapping MapTilerType to its template URL.
TileLayerOptions maptiler({
  required String apikey,
  required MapTilerType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    subdomains: 'abcd',
    attribution: '&copy; MapTiler, &copy; OpenStreetMap contributors',
    tileSize: 512,
    zoomOffset: -1,
    maxZoom: 21,
  );

  switch (type) {
    case MapTilerType.Default:
    case MapTilerType.Streets:
      return opts.copy(
        templateUrl:
            'https://api.maptiler.com/maps/streets/{z}/{x}/{y}{r}.png?key=$apikey',
      );
    case MapTilerType.Basic:
      return opts.copy(
        templateUrl:
            'https://api.maptiler.com/maps/basic/{z}/{x}/{y}{r}.png?key=$apikey',
      );
    case MapTilerType.Bright:
      return opts.copy(
        templateUrl:
            'https://api.maptiler.com/maps/bright/{z}/{x}/{y}{r}.png?key=$apikey',
      );
    case MapTilerType.Pastel:
      return opts.copy(
        templateUrl:
            'https://api.maptiler.com/maps/pastel/{z}/{x}/{y}{r}.png?key=$apikey',
      );
    case MapTilerType.Positron:
      return opts.copy(
        templateUrl:
            'https://api.maptiler.com/maps/positron/{z}/{x}/{y}{r}.png?key=$apikey',
      );
    case MapTilerType.Hybrid:
      return opts.copy(
        templateUrl:
            'https://api.maptiler.com/maps/hybrid/{z}/{x}/{y}{r}.jpg?key=$apikey',
      );
    case MapTilerType.Toner:
      return opts.copy(
        templateUrl:
            'https://api.maptiler.com/maps/toner/{z}/{x}/{y}{r}.png?key=$apikey',
      );
    case MapTilerType.Topo:
      return opts.copy(
        templateUrl:
            'https://api.maptiler.com/maps/topo/{z}/{x}/{y}{r}.png?key=$apikey',
      );
    case MapTilerType.Voyager:
      return opts.copy(
        templateUrl:
            'https://api.maptiler.com/maps/voyager/{z}/{x}/{y}{r}.png?key=$apikey',
      );
  }
}

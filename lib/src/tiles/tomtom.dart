import '../layer/layer.dart';
import '../type.dart';

/// Mapping TomTomType to its template URL.
TileLayerOptions tomtom({
  required String apikey,
  required TomTomType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    subdomains: 'abcd',
    attribution: '&copy;  1992 - ${DateTime.now().year} TomTom',
    maxZoom: 22,
  );

  switch (type) {
    case TomTomType.Basic:
      return opts.copy(
        templateUrl:
            'https://{s}.api.tomtom.com/map/1/tile/basic/main/{z}/{x}/{y}.png?key=$apikey',
      );
    case TomTomType.Hybrid:
      return opts.copy(
        templateUrl:
            'https://{s}.api.tomtom.com/map/1/tile/hybrid/main/{z}/{x}/{y}.png?key=$apikey',
      );
    case TomTomType.Labels:
      return opts.copy(
        templateUrl:
            'https://{s}.api.tomtom.com/map/1/tile/labels/main/{z}/{x}/{y}.png?key=$apikey',
      );
  }
}

import '../layer/layer.dart';
import '../type.dart';

/// Mapping JawgType to its template URL.
TileLayerOptions jawg({
  required JawgType type,
  required String accessToken,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    subdomains: 'abcd',
    attribution: '&copy; Jawg Maps, &copy; OpenStreetMap contributors',
    maxZoom: 22,
  );

  switch (type) {
    case JawgType.Streets:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.jawg.io/jawg-streets/{z}/{x}/{y}{r}.png?access-token=$accessToken',
      );
    case JawgType.Dark:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.jawg.io/jawg-dark/{z}/{x}/{y}{r}.png?access-token=$accessToken',
      );
    case JawgType.Light:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.jawg.io/jawg-light/{z}/{x}/{y}{r}.png?access-token=$accessToken',
      );
    case JawgType.Matrix:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.jawg.io/jawg-matrix/{z}/{x}/{y}{r}.png?access-token=$accessToken',
      );
    case JawgType.Sunny:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.jawg.io/jawg-sunny/{z}/{x}/{y}{r}.png?access-token=$accessToken',
      );
    case JawgType.Terrain:
      return opts.copy(
        templateUrl:
            'https://{s}.tile.jawg.io/jawg-terrain/{z}/{x}/{y}{r}.png?access-token=$accessToken',
      );
  }
}

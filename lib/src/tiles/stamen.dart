import '../layer/layer.dart';
import '../type.dart';

/// Mapping StamenType to its template URL.
TileLayerOptions stamen({
  required StamenType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    subdomains: 'abcd',
    attribution:
        'Map tiles by Stamen Design, CC BY 3.0 &mdash; Map data: &copy; OpenStreetMap contributors',
    maxZoom: 20,
  );

  switch (type) {
    case StamenType.Toner:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/toner/{z}/{x}/{y}{r}.png',
      );
    case StamenType.TonerBackground:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-background/{z}/{x}/{y}{r}.png',
      );
    case StamenType.TonerHybrid:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-hybrid/{z}/{x}/{y}{r}.png',
      );
    case StamenType.TonerLines:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lines/{z}/{x}/{y}{r}.png',
      );
    case StamenType.TonerLabels:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-labels/{z}/{x}/{y}{r}.png',
      );
    case StamenType.TonerLite:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}{r}.png',
      );
    case StamenType.Watercolor:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.jpg',
        maxZoom: 16,
        minZoom: 1,
      );
    case StamenType.Terrain:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/terrain/{z}/{x}/{y}{r}.png',
        maxZoom: 18,
      );
    case StamenType.TerrainBackground:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/terrain-background/{z}/{x}/{y}{r}.png',
        maxZoom: 18,
      );
    case StamenType.TerrainLabels:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/terrain-labels/{z}/{x}/{y}{r}.png',
        maxZoom: 18,
      );
    case StamenType.Relief:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/relief/{z}/{x}/{y}{r}.png',
        maxZoom: 18,
      );
    case StamenType.TopOSMRelief:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/toposm-color-relief/{z}/{x}/{y}.jpg',
        bounds: [
          [22, -132],
          [51, -56]
        ],
      );
    case StamenType.TopOSMFeatures:
      return opts.copy(
        templateUrl:
            'https://stamen-tiles-{s}.a.ssl.fastly.net/toposm-features/{z}/{x}/{y}.png',
        bounds: [
          [22, -132],
          [51, -56]
        ],
        opacity: 0.9,
      );
  }
}

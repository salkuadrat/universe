import '../layer/layer.dart';
import '../type.dart';

/// Mapping CartoDBType to its template URL.
TileLayerOptions cartodb({
  required CartoDBType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    subdomains: 'abcd',
    attribution: 'Map data &copy; OpenStreetMap contributors, &copy; CARTO',
    maxZoom: 19,
  );

  switch (type) {
    case CartoDBType.Positron:
      return opts.copy(
        templateUrl:
            'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
      );
    case CartoDBType.PositronNoLabels:
      return opts.copy(
        templateUrl:
            'https://{s}.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}{r}.png',
      );
    case CartoDBType.PositronOnlyLabels:
      return opts.copy(
        templateUrl:
            'https://{s}.basemaps.cartocdn.com/light_only_labels/{z}/{x}/{y}{r}.png',
      );
    case CartoDBType.DarkMatter:
      return opts.copy(
        templateUrl:
            'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
      );
    case CartoDBType.DarkMatterNoLabels:
      return opts.copy(
        templateUrl:
            'https://{s}.basemaps.cartocdn.com/dark_nolabels/{z}/{x}/{y}{r}.png',
      );
    case CartoDBType.DarkMatterOnlyLabels:
      return opts.copy(
        templateUrl:
            'https://{s}.basemaps.cartocdn.com/dark_only_labels/{z}/{x}/{y}{r}.png',
      );
    case CartoDBType.Voyager:
      return opts.copy(
        templateUrl:
            'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
      );
    case CartoDBType.VoyagerNoLabels:
      return opts.copy(
        templateUrl:
            'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}{r}.png',
      );
    case CartoDBType.VoyagerOnlyLabels:
      return opts.copy(
        templateUrl:
            'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_only_labels/{z}/{x}/{y}{r}.png',
      );
    case CartoDBType.VoyagerLabelsUnder:
      return opts.copy(
        templateUrl:
            'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_labels_under/{z}/{x}/{y}{r}.png',
      );
  }
}

import '../layer/layer.dart';
import '../shared.dart';
import '../type.dart';

/// Mapping WaymarkedTrailsType to its template URL.
TileLayerOptions waymarkedtrails({
  required WaymarkedTrailsType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    attribution:
        '$osmAttrDef | Map style: &copy; waymarkedtrails.org (CC-BY-SA)',
    maxZoom: 18,
  );

  if (type == WaymarkedTrailsType.Hiking) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/hiking/{z}/{x}/{y}.png',
    );
  }

  if (type == WaymarkedTrailsType.Cycling) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/cycling/{z}/{x}/{y}.png',
    );
  }

  if (type == WaymarkedTrailsType.MTB) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/mtb/{z}/{x}/{y}.png',
    );
  }

  if (type == WaymarkedTrailsType.Slopes) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/slopes/{z}/{x}/{y}.png',
    );
  }

  if (type == WaymarkedTrailsType.Riding) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/riding/{z}/{x}/{y}.png',
    );
  }

  if (type == WaymarkedTrailsType.Skating) {
    return opts.copy(
      templateUrl: 'https://tile.waymarkedtrails.org/skating/{z}/{x}/{y}.png',
    );
  }

  return options;
}

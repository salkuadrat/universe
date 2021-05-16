import '../../shared.dart';

class MapLayerOptions {
  /// String to be shown in the attribution control, e.g. "© OpenStreetMap contributors".
  /// It describes the layer data and is often a legal obligation towards
  /// copyright holders and tile providers.
  final String attribution;

  const MapLayerOptions({
    this.attribution = attributionDef,
  });

  MapLayerOptions copy({String? attribution}) => MapLayerOptions(
        attribution: attribution ?? this.attribution,
      );
}

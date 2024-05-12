import '../layer/layer.dart';
import '../type.dart';

/// Mapping GoogleMapType to its template URL.
TileLayerOptions google({
  required GoogleMapType type,
  required TileLayerOptions options,
}) {
  TileLayerOptions opts = options.copy(
    subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
    attribution: 'Map Data &copy; Google',
  );

  switch (type) {
    case GoogleMapType.Street:
      return opts.copy(
        templateUrl: 'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
      );
    case GoogleMapType.Satellite:
      return opts.copy(
        templateUrl: 'https://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}',
      );
    case GoogleMapType.Hybrid:
      return opts.copy(
        templateUrl: 'https://{s}.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
      );
    case GoogleMapType.Terrain:
      return opts.copy(
        templateUrl: 'https://{s}.google.com/vt/lyrs=p&x={x}&y={y}&z={z}',
      );
  }
}

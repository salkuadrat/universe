import '../../core/core.dart';
import '../layer.dart';

class MarkerLayerOptions extends LayerOptions {
  final LatLng latlng;
  final Marker marker;
  final MarkerIcon icon;
  final double opacity;

  MarkerLayerOptions(dynamic latlng, {this.marker, this.icon, num opacity=1.0})
    : this.latlng = LatLng.from(latlng), this.opacity=opacity.toDouble();
}
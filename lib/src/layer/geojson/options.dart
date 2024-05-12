// ignore_for_file: constant_identifier_names

import '../../shared.dart';
import '../layer.dart';

enum GeoJSONPointAs {
  Marker,
  Circle,
}

class GeoJSONLayerOptions extends FeatureLayerOptions {
  final GeoJSONPointAs pointAs;
  final double pointRadius;
  final RadiusUnit radiusUnit;
  final MarkerLayerOptions? pointOptions;
  final PolylineLayerOptions? lineStringOptions;
  final PolygonLayerOptions? polygonOptions;
  final CircleLayerOptions? circleOptions;
  final PathLayerOptions? geometryCollectionOptions;

  GeoJSONLayerOptions({
    double opacity = opacityDef,
    double rotation = rotationDef,
    bool interactive = interactiveDef,
    String attribution = attributionDef,
    this.pointRadius = 0.0,
    this.radiusUnit = RadiusUnit.METER,
    this.pointOptions,
    this.lineStringOptions,
    this.polygonOptions,
    this.circleOptions,
    this.geometryCollectionOptions,
    TapLayerCallback? onTap,
    TapUpLayerCallback? onTapUp,
    TapDownLayerCallback? onTapDown,
    TapLayerCallback? onTapCancel,
    TapLayerCallback? onSecondaryTap,
    TapDownLayerCallback? onSecondaryTapDown,
    TapUpLayerCallback? onSecondaryTapUp,
    TapLayerCallback? onSecondaryTapCancel,
    DoubleTapLayerCallback? onDoubleTap,
    LongPressLayerCallback? onLongPress,
    LongPressStartLayerCallback? onLongPressStart,
    LongPressMoveUpdateLayerCallback? onLongPressMoveUpdate,
    LongPressUpLayerCallback? onLongPressUp,
    LongPressEndLayerCallback? onLongPressEnd,
    LongPressLayerCallback? onSecondaryLongPress,
    LongPressStartLayerCallback? onSecondaryLongPressStart,
    LongPressMoveUpdateLayerCallback? onSecondaryLongPressMoveUpdate,
    LongPressUpLayerCallback? onSecondaryLongPressUp,
    LongPressEndLayerCallback? onSecondaryLongPressEnd,
  })  : pointAs =
            pointRadius > 0.0 ? GeoJSONPointAs.Circle : GeoJSONPointAs.Marker,
        super(
          opacity: opacity,
          rotation: rotation,
          interactive: interactive,
          attribution: attribution,
          onTap: onTap,
          onTapUp: onTapUp,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          onSecondaryTap: onSecondaryTap,
          onSecondaryTapDown: onSecondaryTapDown,
          onSecondaryTapUp: onSecondaryTapUp,
          onSecondaryTapCancel: onSecondaryTapCancel,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onLongPressStart: onLongPressStart,
          onLongPressMoveUpdate: onLongPressMoveUpdate,
          onLongPressUp: onLongPressUp,
          onLongPressEnd: onLongPressEnd,
          onSecondaryLongPress: onSecondaryLongPress,
          onSecondaryLongPressStart: onSecondaryLongPressStart,
          onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
          onSecondaryLongPressUp: onSecondaryLongPressUp,
          onSecondaryLongPressEnd: onSecondaryLongPressEnd,
        );
}

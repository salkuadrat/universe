import 'dart:math';
import 'package:cubit/cubit.dart';
import 'package:flutter/rendering.dart';

import '../core/geometry/point.dart';
import '../core/geometry/size.dart';
import '../core/geometry/latlng_bounds.dart';
import '../core/latlng/latlng.dart';
import '../map/options/fitbounds.dart';
import '../shared.dart';
import 'state.dart';

class MapManager extends Cubit<MapState> {
  MapManager(MapState state) : super(state);
  
  init() {
    state.check();
    emit(state.withManager(this));

    if(state.hasRotation) {
      rotate(state.rotation);
    }
  }

  refresh() {
    MapState originalState = MapState(
      controller: state.controller, 
      options: state.options,
    );

    emit(originalState.withManager(this));
  }

  resize(double width, double height) {
    Size size = Size(width, height);
    emit(state.copyWith(size: size));
    if(state.hasRotation) {
      rotate(state.rotation);
    }
  }

  move(dynamic center, num zoom, {bool hasGesture = false}) {
    center = LatLng.from(center);
    zoom = state.limitZoom(zoom.toDouble());

  }

  fitBounds(dynamic bounds, 
    [FitBoundsOptions options=const FitBoundsOptions(padding: EdgeInsets.all(12.0))]) {
    bounds = LatLngBounds.from(bounds);

    if(bounds.isNotValid) {
      throw Exception('Bounds are not valid');
    }

    final target = state.getBoundsCenterZoom(bounds, options ?? FitBoundsOptions());
    
    move(target.center, target.zoom);
  }

  fitWorld([FitBoundsOptions options]) {
    fitBounds([[-90.0, -180.0], [90.0, 180.0]], options);
  }

  setMinZoom(double minZoom) {
    emit(state.withMinZoom(minZoom));
    if(state.zoom < minZoom) {
      setZoom(minZoom);
    }
  }

  setMaxZoom(double maxZoom) {
    emit(state.withMaxZoom(maxZoom));
    if(state.zoom > maxZoom) {
      setZoom(maxZoom);
    }
  }

  setZoom(double zoom, [options]) {
    move(state.center, zoom);
  }

  setZoomAround(dynamic position, double zoom, [options]) {
    GeoPoint centerPoint = state.centerPoint;
    GeoPoint containerPoint;

    double scale = state.getZoomScale(zoom);

    if(position is GeoPoint) {
      containerPoint = position;
    } else if(position is LatLng) {
      containerPoint = state.latlngToPoint(position);
    } else {
      position = LatLng.from(position);
      containerPoint = state.latlngToPoint(position);
    }

    if(containerPoint != null) {
      GeoPoint offset = (containerPoint - centerPoint) * (1 - (1  / scale));
      centerPoint = centerPoint + offset;
      LatLng center = state.pointToLatLng(centerPoint);
      move(center, zoom);
    }
  }

  zoomIn(double delta, [options]) { 
    // TODO recalcualate delta based on options.zoomDelta
    setZoom(state.zoom + delta, options);
  }

  zoomOut(double delta, [options]) {
    // TODO recalcualate delta based on options.zoomDelta
    setZoom(state.zoom - delta, options);
  }

  rotate(double degree) {
    if(degree != 0.0) {
      double angle = degToRadian(degree);
      double rad90 = 90.0 * PI / 180.0;
      double rangle90 = sin(rad90 - angle).abs();
      double sinangle = sin(angle).abs();

      double width = (state.width * rangle90) + (state.height * sinangle);
      double height = (state.height * rangle90) + (state.width * sinangle);

      Size size = Size(width, height);
      emit(state.copyWith(size: size, rotation: degree));
    }
  }

  dispose() {

  } 
}
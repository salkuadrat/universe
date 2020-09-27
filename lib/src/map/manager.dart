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
    UPoint halfSize = state.halfSize;
    UPoint containerPoint;
    
    double scale = state.getZoomScale(zoom);

    if(position is UPoint) {
      containerPoint = position;
    } else if(position is LatLng) {
      containerPoint = state.latlngToPoint(position);
    } else {
      position = LatLng.from(position);
      containerPoint = state.latlngToPoint(position);
    }

    if(containerPoint != null) {
      UPoint offset = (containerPoint - halfSize) * (1 - (1  / scale));
      LatLng center = state.pointToLatLng(halfSize + offset);
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

  /// Tries to locate the user using the Geolocation API, 
  /// firing a [`locationfound`](#map-locationfound) event with location data on success 
  /// or a [`locationerror`](#map-locationerror) event on failure, 
  /// and optionally sets the map view to the user's location with respect to 
  /// detection accuracy (or to the world view if geolocation failed).
  locate({bool watch=true}) {

  }

  /// Stops watching location previously initiated by `map.locate({watch: true})` 
  /// and aborts resetting the map view if map.locate was called 
  /// with `{setView: true}`
  stopLocate() {

  }

  dispose() {

  } 
}
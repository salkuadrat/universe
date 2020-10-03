import 'dart:async';

import 'package:cubit/cubit.dart';
import 'package:flutter/rendering.dart';
import 'package:location/location.dart';
import 'package:universe/src/shared.dart';

import '../core/core.dart';
import 'map.dart';

class MapStateManager extends Cubit<MapState> {
  
  MapStateManager(MapState state) : super(state);

  MapOptions get options => state.options;

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  Location _location;
  
  double _angle = 0.0;
  double _angleStart = 0.0;
  Function _onAngleChanged;

  double get angle => _angle;
  double get angleStart => _angleStart;
  
  StreamController<MapData> positionStream;
  
  init() {
    state.init();
    positionStream = StreamController.broadcast(sync: true);
    emit(state.withManager(this));

    _initLocation();
    
    if(state.options.hasBounds) {
      fitBounds(options.bounds, options.fitBoundsOptions);
    } else {
      move(options.center, options.zoom);
    }
  }

  Future _initLocation() async {
    _location = new Location();

    if(state.options.live) {
      await _initLocationSettings();

      _location.onLocationChanged.listen((locationData) { 
        print('Live location: $locationData');

        LatLng center = LatLng(
          locationData.latitude, 
          locationData.longitude, 
          locationData.altitude,
        );

        move(center, 17.01122);  
      });
    }
  }

  Future _initLocationSettings() async {
    _serviceEnabled = await _location.serviceEnabled();
      
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  setAngleListener(Function onAngleChanged) {
    _onAngleChanged = onAngleChanged;
  }

  reset() {
    MapState originalState = MapState(
      controller: state.controller, 
      options: state.options,
    );

    emit(originalState.withManager(this));
  }

  resize(double width, double height) {
    Size newSize = Size(width, height);
    emit(state.copyWith(size: newSize));
  }

  move(dynamic center, num zoom, {bool hasGesture = false}) {
    
    center = LatLng.from(center);
    zoom = state.limitZoom(zoom.toDouble());

    bool isZoomChanged = state.isNotEqualZoom(zoom);
    bool isCenterChanged = state.center.notEqual(center);
    bool isMapChanged = isZoomChanged || isCenterChanged;
    bool isMapNotChanged = !isMapChanged;

    // if not moved (center is not changed or bounds is not valid)
    if(state.hasCenter && (isMapNotChanged || state.bounds.isNotValid)) {
      return;
    }

    if(state.isOutOfBounds(center)) {
      if(!state.options.slideOnBoundaries) {
        return;
      }

      center = state.containLatLng(center, state.center);
      isCenterChanged = state.center.notEqual(center);
    }
    
    emit(state.copyWith(center: center, zoom: zoom, rotation: radianToDeg(_angle)));
    state.onChanged(state.center, state.zoom, state.rotation);
    positionStream.add(MapData(center: center, zoom: zoom));
  }

  fitBounds(dynamic bounds, [FitBoundsOptions options]) {
    LatLngBounds latlngBounds = LatLngBounds.from(bounds);

    if(latlngBounds.isNotValid) {
      throw Exception('Bounds are not valid');
    }

    final target = state.getBoundsCenterZoom(
      latlngBounds, options ?? FitBoundsOptions());
    
    move(target.center, target.zoom);
  }

  fitWorld([FitBoundsOptions options]) {
    fitBounds([[-90.0, -180.0], [90.0, 180.0]], options);
  }

  setMinZoom(double minZoom) {
    emit(state.withMinZoom(minZoom));
    if(state.zoom < minZoom) {
      zoom(minZoom);
    }
  }

  setMaxZoom(double maxZoom) {
    emit(state.withMaxZoom(maxZoom));
    if(state.zoom > maxZoom) {
      zoom(maxZoom);
    }
  }

  zoom(double zoom) {
    move(state.center, zoom);
  }

  setZoomAround(dynamic position, double zoom, [options]) {
    UPoint halfSize = UPoint.from(state.halfSize);
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

  zoomIn([double zoomDelta = zoomDeltaDef]) { 
    zoomDelta ??= options.zoomDelta;
    zoom(state.zoom + zoomDelta);
  }

  zoomOut([double zoomDelta = zoomDeltaDef]) {
    zoomDelta ??= options.zoomDelta;
    zoom(state.zoom - zoomDelta);
  }

  setAngle(angle) {
    _angle = angle;
    _onAngleChanged?.call();
    emit(state.copyWith(rotation: radianToDeg(_angle)));
  }

  setAngleStart(angleStart) {
    _angleStart = angleStart;
  }

  /// rotate map (value in degree)
  /* rotate(double rotation) {
    print('rotate map $rotation');
    emit(state.copyWith(rotation: rotation));
    state.onRotationChanged(rotation);
  } */

  /// Tries to locate the user using the Geolocation API, 
  /// firing a [`locationfound`](#map-locationfound) event with location data on success 
  /// or a [`locationerror`](#map-locationerror) event on failure, 
  /// and optionally sets the map view to the user's location with respect to 
  /// detection accuracy (or to the world view if geolocation failed).
  locate() async {
    _initLocationSettings();
    LocationData locationData = await _location.getLocation();

    LatLng center = LatLng(
      locationData.latitude, 
      locationData.longitude, 
      locationData.altitude,
    );
    
    move(center, 17.01122);
  }
  
  /// Stops watching location previously initiated by `map.locate({watch: true})` 
  /// and aborts resetting the map view if map.locate was called 
  /// with `{setView: true}`
  stopLocate() {

  }

  dispose() {
    positionStream?.close();
  } 
}
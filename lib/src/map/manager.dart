import 'dart:async';

import 'package:cubit/cubit.dart';
import 'package:curved_animation_controller/curved_animation_controller.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

import '../core/core.dart';
import '../shared.dart';
import 'map.dart';

class MapStateManager extends Cubit<MapState> {
  
  MapStateManager(MapState state) : super(state);
  
  MapOptions? get options => state.options;

  late bool _serviceEnabled;
  PermissionStatus? _permissionGranted;

  late Location _location;
  StreamSubscription? _locationSubs;
  
  double _angle = 0.0;
  double _angleStart = 0.0;
  Function? _onAngleChanged;

  double get angle => _angle;
  double get angleStart => _angleStart;

  late TickerProvider _vsync;
  CurvedAnimationController? _rotateAnim;
  CurvedAnimationController? _moveAnim;
  CurvedAnimationController? _zoomAnim;

  StreamController<MapData>? positionStream;
  
  Future init(TickerProvider vsync) async {
    state.init();

    _vsync = vsync;
    _angle = state.angle;
    
    positionStream = StreamController.broadcast(sync: true);
    emit(state.withManager(this));

    await _initLocation();
    
    if(options!.hasFitBounds) {
      fitBounds(options!.fitBounds, options!.fitBoundsOptions);
    } else if(options!.hasCenterQuery) {
      await _locateCenter(options!.center);
    } else if(options!.hasCenter) {
      move(options!.center, options!.zoom);
    } else {
      fitWorld();
    }

    state.controller?.onReady?.call();
  }

  Future _locateCenter([LatLng? defaultCenter]) async {
    LatLng center = defaultCenter ?? LatLng(0.0, 0.0, 0.0);
    move(center, options!.zoom);

    LatLng? latlng = await findLocation(options!.centerQuery!);

    if(latlng != null) {
      center = latlng;
      emit(state.copyWith(optionCenter: latlng));
      move(latlng, options!.zoom);
    }
  }

  Future _initLocation() async {
    _location = new Location();

    if(state.options!.live) {
      emit(state.startLocating());
      await _initLocationSettings();

      _locationSubs = _location.onLocationChanged.listen((locationData) { 
        LatLng location = LatLng(
          locationData.latitude, 
          locationData.longitude, 
          locationData.altitude,
        );

        emit(state.copyWith(location: location));

        if(state.options!.moveWhenLive) {
          move(location, 17.01122, true);
        }
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

  _move(LatLng? center, double? zoom) {
    zoom = state.limitZoom(zoom);

    bool isZoomChanged = state.isNotEqualZoom(zoom);
    bool isCenterChanged = state.hasCenter && state.center!.notEqual(center);
    bool isMapChanged = isZoomChanged || isCenterChanged;
    bool isMapNotChanged = !isMapChanged;
    bool boundsNotValid = state.hasMaxBounds && state.bounds.isNotValid;

    // if not moved (center is not changed or bounds is not valid)
    if(isMapNotChanged || boundsNotValid) {
      return;
    }

    if(state.isOutOfBounds(center)) {
      if(!state.options!.slideOnBoundaries) {
        return;
      }

      center = state.safeCenter(center, state.center);
      isCenterChanged = state.center!.notEqual(center);
    }

    emit(state.copyWith(center: center, zoom: zoom, rotation: radianToDeg(_angle)));
    state.onChanged(state.center, state.zoom, state.rotation);
    positionStream!.add(MapData(center: center, zoom: zoom));
  }

  Future move(dynamic center, double? zoom, [bool animate = false]) async {
    if(center is String) {
      center = await (findLocation(center) as FutureOr<String>);
    } else {
      center = LatLng.from(center);
    }

    if(center == null) {
      return;
    }

    if(animate) {
      //_moveAnim?.dispose();
      //_zoomAnim?.dispose();

      _moveAnim = CurvedAnimationController.tween(
        LatLngTween(begin: state.center, end: center), 
        Duration(milliseconds: 250),
        curve: Curves.ease,
        vsync: _vsync,
      );

      _zoomAnim = CurvedAnimationController(
        begin: state.zoom, end: zoom,
        duration: Duration(milliseconds: 250),
        curve: Curves.ease,
        vsync: _vsync,
      );

      _moveAnim!.addListener(() {
        _move(_moveAnim!.value, state.zoom);
      });

      _zoomAnim!.addListener(() {
        emit(state.copyWith(zoom: _zoomAnim!.value));
      });

      _moveAnim!.addStatusListener((status) { 
        if(status == AnimationStatus.completed) {
          _moveAnim?.dispose();
        }
      });

      _zoomAnim!.addStatusListener((status) { 
        if(status == AnimationStatus.completed) {
          _zoomAnim?.dispose();
        }
      });
      
      _moveAnim?..reset()..start();
      _zoomAnim?..reset()..start();
    } else {
      _move(center, zoom);
    }
  }

  fitBounds(dynamic bounds, [FitBoundsOptions? options]) {
    LatLngBounds latlngBounds = LatLngBounds.from(bounds);

    if(latlngBounds.isNotValid) {
      throw Exception('Bounds are not valid');
    }

    final target = state.getBoundsCenterZoom(latlngBounds, options ?? FitBoundsOptions());
    
    move(target.center, target.zoom, true);
  }

  fitWorld([FitBoundsOptions? options]) {
    fitBounds([[-90.0, -180.0], [90.0, 180.0]], options);
  }

  setMinZoom(double minZoom) {
    emit(state.withMinZoom(minZoom));
    if(state.zoom! < minZoom) {
      zoom(minZoom);
    }
  }

  setMaxZoom(double maxZoom) {
    emit(state.withMaxZoom(maxZoom));
    if(state.zoom! > maxZoom) {
      zoom(maxZoom);
    }
  }

  zoom(double zoom, [bool animate = false]) {
    if(animate) {
      //_zoomAnim?.dispose();

      _zoomAnim = CurvedAnimationController(
        begin: state.zoom, end: zoom,
        duration: Duration(milliseconds: 250),
        curve: Curves.ease,
        vsync: _vsync,
      );

      _zoomAnim!.addListener(() {
        _move(state.center, _zoomAnim!.value);
      });

      _zoomAnim!.addStatusListener((status) { 
        if(status == AnimationStatus.completed) {
          _zoomAnim?.dispose();
        }
      });

      _zoomAnim?..reset()..start();
    } else {
      _move(state.center, zoom);
    }
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

    UPoint offset = (containerPoint - halfSize) * (1 - (1  / scale));
    LatLng? center = state.pointToLatLng(halfSize + offset);
    move(center, zoom);
  }

  zoomIn([double zoomDelta = zoomDeltaDef]) { 
    zoom(state.zoom! + zoomDelta);
  }

  zoomOut([double zoomDelta = zoomDeltaDef]) {
    zoom(state.zoom! - zoomDelta);
  }

  setAngle(angle) {
    _angle = angle;
    _onAngleChanged?.call();
    emit(state.copyWith(rotation: radianToDeg(_angle)));
  }

  setAngleStart(angleStart) {
    _angleStart = angleStart;
  }

  rotate(double rotation, [bool animate = false, Function? onAnimateEnd]) {
    if(animate) {
      _rotateAnim = CurvedAnimationController(
        begin: normalizeDeg(state.rotation), end: normalizeDeg(rotation),
        vsync: _vsync, duration: Duration(milliseconds: 250), 
        curve: Curves.ease,
      );

      _rotateAnim!.addListener(() {
        setAngle(degToRadian(_rotateAnim!.value));
      });

      _rotateAnim!.addStatusListener((status) { 
        if(status == AnimationStatus.completed) {
          onAnimateEnd?.call();
          _rotateAnim?.dispose();
        }
      });

      _rotateAnim?..reset()..start();
    } else {
      setAngle(degToRadian(rotation));
    }
  }

  // Find LatLng from location name
  Future<LatLng?> findLocation(String query) async {
    List<Address>? locations = await Geocoder.local.findAddressesFromQuery(query);

    if(locations != null && locations.length > 0) {
      Address location = locations.first;
      return LatLng(
        location.coordinates!.latitude, 
        location.coordinates!.longitude,
      );
    }

    return null;
  }
  
  /// Tries to locate the current user location.
  /// 
  /// Return LatLng location if found, 
  /// and optionally sets the map view to the user's location
  /// (or stay in previous location if geolocation failed).
  Future<LatLng?> locate([bool automove = false, double zoom = 17.0]) async {
    emit(state.startLocating());
    await _initLocationSettings();
    LatLng? location;
    LocationData locationData = await _location.getLocation();

    location = LatLng(
      locationData.latitude, 
      locationData.longitude, 
      locationData.altitude,
    );

    emit(state.updateLocation(location));

    if(automove) {
      move(location, (zoom + 0.01212), true);
      rotate(0.0, true);
    }

    emit(state.stopLocating());
    return location;
  }

  dispose() {
    _locationSubs?.cancel();
    positionStream?.close();
  } 

  @override 
  Future<void> close() async {
    dispose();
    super.close();
  }
}
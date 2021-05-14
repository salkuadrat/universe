import 'dart:async';
import 'dart:math' as math;
import 'package:curved_animation_controller/curved_animation_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

import '../core/core.dart';
import '../log.dart';
import '../shared.dart';
import 'controller/controller.dart';
import 'interactive/interactive.dart';
import 'options/options.dart';

class MapStates extends ChangeNotifier {

  late MapController _originalController;
  late MapOptions _originalOptions;

  late MapController _controller;
  late MapOptions _options;
  late LatLng _center;
  late double _zoom;
  late double _minZoom;
  late double _maxZoom;
  late double _rotation;
  late Size _size;
  late bool _isLocating;

  LatLng? _position;
  Location? _location;
  StreamSubscription? _locationSubs;
  late StreamController<MapData> _positionStream;

  late TickerProvider _vsync;
  CurvedAnimationController? _rotateAnim;
  CurvedAnimationController? _moveAnim;
  CurvedAnimationController? _zoomAnim;

  double _angle = 0.0;
  double _angleStart = 0.0;

  Function? onTap;
  Function? onLongPress;
  Function? _onAngleChanged;
  Function? _onTileChanged;

  MapStates({
    required MapController controller,
    required MapOptions options,
    this.onTap,
    this.onLongPress,
  }) {
    _originalController = controller;
    _originalOptions = options;

    _controller = controller;
    _options = options;
    _center = options.center!;
    _zoom = options.zoom;
    _minZoom = options.minZoom;
    _maxZoom = options.maxZoom;
    _rotation = options.rotation;
    _size = options.size!;
    _isLocating = false;

    _angle = degToRadian(_rotation);
    _controller.onReady = options.onReady;
    _controller.onChanged = options.onChanged;
    _controller.map = this;

    assert(
      options.slideOnBoundaries || 
      (options.centerQuery != null && options.centerQuery!.isNotEmpty) || 
      (options.center != null && !_isOutOfBounds(options.center))
    );
  }

  StreamController<MapData> get positionStream => _positionStream;
  MapController get controller => _controller;
  MapOptions get options => _options;

  Crs get crs => options.crs;
  LatLng get center => _center;
  double get zoom => _zoom;
  double get minZoom => _minZoom;
  double get maxZoom => _maxZoom;
  double get rotation => _rotation;
  Size get size => _size;

  double get angle => _angle;
  double get angleStart => _angleStart;

  bool get isLocating => _isLocating;
  bool get isNotLocating => !isLocating;
  Location? get location => _location;
  LatLng? get position => _position;

  late SafeBounds _safeBoundsCache;
  //late double _safeBoundsZoom;

  bool get hasMaxBounds => _options.hasMaxBounds;
  LatLng? get swBound => _options.maxBounds?.southWest;
  LatLng? get neBound => _options.maxBounds?.northEast;

  bool get canRotate => _options.canRotate;
  bool get hasRotation => _rotation > 0.0;
  bool get showCenterMarker => _options.showCenterMarker;
  bool get showLocationMarker => _options.showLocationMarker && _position != null;

  dynamic get centerMarker => _options.centerMarker;
  dynamic get locationMarker => _options.locationMarker;

  double get width => _size.width;
  double get height => _size.height;

  Size get _halfSize => _size / 2;
  UPoint get _halfPoint => UPoint.from(_halfSize);

  double  get _widthInDegrees => _size.width * (360 / math.pow(2, _zoom + 8));
  double get _heightInDegrees => (_size.height * 170.102258) / math.pow(2, _zoom + 8);
  
  UPoint get centerPoint => getCenterPoint(_center, _zoom);
  UPoint get pixelOrigin => getPixelOrigin(_center, _zoom);

  UPoint getCenterPoint(LatLng? center, [double? zoom]) {
    return project(center, zoom ?? _zoom);
  }

  UPoint getPixelOrigin(LatLng? center, [double? zoom]) {
    return (getCenterPoint(center, zoom) - _halfPoint).round();
  }

  Bounds? getPixelWorldBounds(double? zoom) {
    return crs.getProjectedBounds(zoom ?? _zoom);
  }

  Bounds get pixelBounds => getPixelBounds(_center, _zoom);

  Bounds getPixelBounds(LatLng center, double zoom) {
    double scale = getZoomScale(zoom, _zoom);

    UPoint centerPoint = getCenterPoint(center, zoom).floor();
    UPoint offset = UPoint.from(_halfSize / scale);

    return Bounds(centerPoint - offset, centerPoint + offset);
  }

  LatLngBounds get bounds {
    final bounds = pixelBounds;

    return LatLngBounds(
      unproject(bounds.bottomLeft),
      unproject(bounds.topRight),
    );
  }
  
  LatLngBounds wrapLatLngBounds(LatLngBounds latlngBounds) {
    return crs.wrapLatLngBounds(latlngBounds);
  }

  double limitZoom([double? zoom]) {
    return math.max(minZoom, math.min(maxZoom, zoom ?? _zoom));
  }

  UPoint project(LatLng? latlng, [double? zoom]) {
    return latlngToPoint(latlng, zoom ?? _zoom);
  }

  UPoint latlngToPoint(LatLng? latlng, [double? zoom]) {
    return crs.latlngToPoint(latlng, zoom ?? _zoom);
  }

  LatLng? unproject(UPoint point, [double? zoom]) {
    return pointToLatLng(point, zoom ?? _zoom);
  }

  LatLng? pointToLatLng(UPoint point, [double? zoom]) {
    return crs.pointToLatLng(point, zoom ?? _zoom);
  }

  UPoint offsetToPoint(Offset offset) {
    return UPoint(offset.dx, offset.dy);
  }

  Offset pointToOffset(UPoint point) {
    return Offset(point.x, point.y);
  }

  Size offsetToSize(Offset offset) {
    return Size(offset.dx, offset.dy);
  }

  Offset sizeToOffset(Size size) {
    return Offset(size.width, size.height);
  }

  LatLng? offsetToLatLng(Offset offset, [double? width, double? height]) {
    width ??= size.width;
    height ??= size.height;
    
    UPoint point = offsetToPoint(offset);
    UPoint centerPoint = project(center);
    UPoint diffPoint = UPoint(
      (width / 2) - point.x, 
      (height / 2) - point.y,
    );

    return unproject(centerPoint - diffPoint);
  }

  /// Returns the scale factor to be applied to a map transition 
  /// from zoom level `fromZoom` to `toZoom`. 
  /// 
  /// Used internally to help with zoom animations.
  double getZoomScale(double toZoom, [double? fromZoom]) {
    return crs.scale(toZoom)! / crs.scale(fromZoom ?? _zoom)!;
  }

  /// Returns the zoom level that the map would end up at, 
  /// if it is at `fromZoom` level and everything is scaled 
  /// by a factor of `scale`. 
  /// 
  /// Inverse of [`getZoomScale`].
  double getScaleZoom(double scale, [double? fromZoom]) {
    return crs.zoom(scale * crs.scale(fromZoom ?? _zoom)!);   
  }

  double getScaledZoom(double fromZoom, double scale) {
    final zoom = fromZoom + (math.log(scale) / math.ln2);
    return limitZoom(zoom);
  }

  bool _isEqualZoom(double zoom, [double maxMargin = 0.005]) {
    return (_zoom - zoom).abs() <= maxMargin;
  }

  bool _isNotEqualZoom(double zoom, [double maxMargin = 0.005]) {
    return !_isEqualZoom(zoom, maxMargin);
  }

  MapData _getBoundsCenterZoom(LatLngBounds bounds, FitBoundsOptions options) {
    UPoint paddingTL = UPoint(options.padding.left, options.padding.top);
    UPoint paddingBR = UPoint(options.padding.right, options.padding.bottom);

    double zoom = _getBoundsZoom(bounds, paddingTL + paddingBR); 
    zoom = math.min(options.maxZoom, zoom);

    if(zoom == double.infinity) {
      return MapData(center: bounds.center, zoom: zoom);
    }

    UPoint swPoint = project(bounds.southWest, zoom);
    UPoint nePoint = project(bounds.northEast, zoom);
    UPoint offset = (paddingBR - paddingTL) / 2;

    UPoint centerPoint = ((swPoint + nePoint) / 2) + offset;
    LatLng? center = unproject(centerPoint, zoom);

    return MapData(center: center, zoom: zoom);
  }

  double _getBoundsZoom(LatLngBounds bounds, UPoint padding, {bool inside=false}) {
    double zoom = _zoom;

    LatLng nw = bounds.northWest;
    LatLng se = bounds.southEast;

    Size size = _size - padding;
    Size boundsSize = Bounds(project(se, zoom), project(nw, zoom)).size;

    double scaleX = size.width / boundsSize.width;
    double scaleY = size.height / boundsSize.height;
    double scale = inside ? math.max(scaleX, scaleY) : math.min(scaleX, scaleY);

    zoom = getScaleZoom(scale, zoom);
    return math.max(_minZoom, math.min(_maxZoom, zoom));
  }

  SafeBounds get _safeBounds {
    if(hasMaxBounds) {
      final halfHeight = _heightInDegrees / 2;
      final halfWidth = _widthInDegrees / 2;
      
      final swLatitude = swBound!.lat + halfHeight;
      final swLongitude = swBound!.lng + halfWidth;
      final neLatitude = neBound!.lat - halfHeight;
      final neLongitude = neBound!.lng - halfWidth;
      
      _safeBoundsCache = SafeBounds(
        LatLng(swLatitude, swLongitude),
        LatLng(neLatitude, neLongitude),
      );

      //_safeBoundsZoom = _zoom;
    }

    return _safeBoundsCache;
  }

  bool _isOutOfBounds(LatLng? center) {
    if(center == null) {
      return true;
    }

    if(hasMaxBounds) {
      if(options.adaptiveBoundaries) {
        return !_safeBounds.contains(center);
      }

      bool isLatOutOfBounds =  
        (center.lat < swBound!.lat) || 
        (center.lat > neBound!.lat);
      
      bool isLngOutOfBounds = 
        (center.lng < swBound!.lng) || 
        (center.lng > neBound!.lng);
      
      if(isLatOutOfBounds || isLngOutOfBounds) {
        return true;
      }
    }

    return false;
  }

  LatLng _safeCenter(LatLng center, LatLng defaultCenter) {
    if(hasMaxBounds) {
      if (options.adaptiveBoundaries) {
        return _safeBounds.containLatLng(center, defaultCenter);
      }

      return LatLng(
        center.lat.clamp(swBound!.lat, neBound!.lat),
        center.lng.clamp(swBound!.lng, neBound!.lng),
      );
    }
    
    return defaultCenter;
  }

  set onAngleChanged(Function onAngleChanged) {
    _onAngleChanged = onAngleChanged;
    notifyListeners();
  }

  void setTileChangedListener(Function listener) {
    _onTileChanged = listener;
  }

  Future init(TickerProvider vsync, Function onAngleChanged) async {
    log('MapStates init');
    
    _vsync = vsync;
    _onAngleChanged = onAngleChanged;
    _positionStream = StreamController.broadcast(sync: true);

    notifyListeners();

    await _initLocation();
    
    if(options.hasFitBounds) {
      fitBounds(options.fitBounds, options.fitBoundsOptions);
    } else if(options.hasCenterQuery) {
      await _locateCenter(options.center);
    } else if(options.hasCenter) {
      move(options.center, options.zoom);
    } else {
      fitWorld();
    }

    controller.onReady?.call();
    notifyListeners();
  }

  void _startLocating() {
    _isLocating = true;
    notifyListeners();
  }

  void _stopLocating() {
    _isLocating = false;
    notifyListeners();
  }

  Future _initLocation() async {
    log('MapStates initLocation');

    _location = new Location();

    if(options.live) {
      _startLocating();
      await _initLocationSettings();

      _locationSubs = _location?.onLocationChanged.listen((data) { 
        _stopLocating();

        _position = LatLng(
          data.latitude, 
          data.longitude, 
          data.altitude,
        );

        notifyListeners();

        if(options.moveWhenLive) {
          move(_position, 17.01122, true);
        }
      });
    }
  }

  Future _initLocationSettings() async {
    bool _serviceEnabled = await _location?.serviceEnabled() ?? false;
      
    if (!_serviceEnabled) {
      _serviceEnabled = await _location?.requestService() ?? false;

      if (!_serviceEnabled) {
        return;
      }
    }

    PermissionStatus? _permissionGranted = await _location?.hasPermission();
    
    if (_permissionGranted == PermissionStatus.denied) {      
      _permissionGranted = await _location?.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future _locateCenter([LatLng? defaultCenter]) async {
    log('MapStates locateCenter');
    
    LatLng? center = await findLocation(options.centerQuery!) ?? defaultCenter ?? _center;

    _center = center;
    _options = _options.copyWith(center: center);

    move(_center, _zoom);
  }

  reset() {
    log('MapStates reset');
    _controller = _originalController;
    _options = _originalOptions;
    notifyListeners();
  }

  resize(double width, double height) {
    log('MapStates resize');
    _size = Size(width, height);
    notifyListeners();
  }

  _move(LatLng center, double? zoom) {
    zoom = limitZoom(zoom);

    bool isZoomChanged = _isNotEqualZoom(zoom);
    bool isCenterChanged = _center.notEqual(center);
    bool isMapChanged = isZoomChanged || isCenterChanged;
    bool isMapNotChanged = !isMapChanged;
    bool boundsNotValid = hasMaxBounds && bounds.isNotValid;

    // if not moved (center is not changed or bounds is not valid)
    if(isMapNotChanged || boundsNotValid) {
      return;
    }

    if(_isOutOfBounds(center)) {
      if(!options.slideOnBoundaries) {
        return;
      }

      center = _safeCenter(center, _center);
      isCenterChanged = center.notEqual(_center);
    }

    _center = center;
    _zoom = zoom;
    _rotation = radianToDeg(_angle);
    _onTileChanged?.call();
    _controller.onChanged?.call(_center, _zoom, _rotation);
    _positionStream.add(MapData(center: _center, zoom: _zoom));

    notifyListeners();
  }

  Future move(dynamic center, double? zoom, [bool animate = false]) async {
    log('MapStates move $center $zoom');

    if(center is String) {
      center = await (findLocation(center) as FutureOr<String>);
    } else {
      center = LatLng.from(center);
    }

    if(center == null) {
      return;
    }

    if(animate) {
      _moveAnim = CurvedAnimationController.tween(
        LatLngTween(begin: _center, end: center), 
        Duration(milliseconds: 250),
        curve: Curves.ease,
        vsync: _vsync,
      );

      _zoomAnim = CurvedAnimationController(
        begin: _zoom, end: zoom,
        duration: Duration(milliseconds: 250),
        curve: Curves.ease,
        vsync: _vsync,
      );

      _moveAnim?.addListener(() {
        _move(_moveAnim!.value, _zoom);
      });

      _zoomAnim?.addListener(() {
        _zoom = _zoomAnim!.value;
        notifyListeners();
      });

      _moveAnim?.addStatusListener((status) { 
        if(status == AnimationStatus.completed) {
          _moveAnim?.dispose();
        }
      });

      _zoomAnim?.addStatusListener((status) { 
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
    log('MapStates fitBounds');

    LatLngBounds latlngBounds = LatLngBounds.from(bounds);

    if(latlngBounds.isNotValid) {
      throw Exception('Bounds are not valid');
    }

    final target = _getBoundsCenterZoom(latlngBounds, options ?? FitBoundsOptions());
    
    move(target.center, target.zoom, true);
  }

  fitWorld([FitBoundsOptions? options]) {
    log('MapStates fitWorld');
    fitBounds([[-90.0, -180.0], [90.0, 180.0]], options);
  }

  set minZoom(double minZoom) {
    _minZoom = minZoom;
    notifyListeners();

    if(_zoom < minZoom) {
      zoomTo(minZoom);
    }
  }

  set maxZoom(double maxZoom) {
    _maxZoom = maxZoom;
    notifyListeners();

    if(_zoom > maxZoom) {
      zoomTo(maxZoom);
    }
  }

  zoomIn([double zoomDelta = zoomDeltaDef]) { 
    zoomTo(_zoom + zoomDelta);
  }

  zoomOut([double zoomDelta = zoomDeltaDef]) {
    zoomTo(_zoom - zoomDelta);
  }

  zoomTo(double zoom, [bool animate = false]) {
    log('MapStates zoomTo $zoom');

    if(animate) {
      _zoomAnim = CurvedAnimationController(
        begin: _zoom, end: zoom,
        duration: Duration(milliseconds: 250),
        curve: Curves.ease,
        vsync: _vsync,
      );

      _zoomAnim?.addListener(() {
        _move(center, _zoomAnim!.value);
      });

      _zoomAnim?.addStatusListener((status) { 
        if(status == AnimationStatus.completed) {
          _zoomAnim?.dispose();
        }
      });

      _zoomAnim?..reset()..start();
    } else {
      _move(center, zoom);
    }
  }

  /* _setZoomAround(dynamic position, double zoom) {
    UPoint halfSize = UPoint.from(_halfSize);
    UPoint containerPoint;
    
    double scale = getZoomScale(zoom);

    if(position is UPoint) {
      containerPoint = position;
    } else if(position is LatLng) {
      containerPoint = latlngToPoint(position);
    } else {
      position = LatLng.from(position);
      containerPoint = latlngToPoint(position);
    }

    UPoint offset = (containerPoint - halfSize) * (1 - (1  / scale));
    LatLng? center = pointToLatLng(halfSize + offset);
    move(center, zoom);
  } */

  set angle(angle) {
    _angle = angle;
    _rotation = radianToDeg(_angle);
    _onAngleChanged?.call();
    notifyListeners();
  }

  set rotation(rotation) {
    _rotation = rotation;
    _angle = degToRadian(_rotation);
    _onAngleChanged?.call();
    notifyListeners();
  }

  set angleStart(angleStart) {
    _angleStart = angleStart;
    notifyListeners();
  }

  rotate(double rotateTo, [bool animate = false, Function? onAnimateEnd]) {
    log('MapStates rotate $rotateTo');

    if(animate) {
      _rotateAnim = CurvedAnimationController(
        begin: normalizeDeg(_rotation), end: normalizeDeg(rotateTo),
        vsync: _vsync, duration: Duration(milliseconds: 250), 
        curve: Curves.ease,
      );

      _rotateAnim?.addListener(() {
        rotation = _rotateAnim!.value;
      });

      _rotateAnim?.addStatusListener((status) { 
        if(status == AnimationStatus.completed) {
          onAnimateEnd?.call();
          _rotateAnim?.dispose();
        }
      });

      _rotateAnim?..reset()..start();
    } else {
      rotation = rotateTo;
    }
  }

  // Find LatLng from location name
  Future<LatLng?> findLocation(String query) async {
    log('MapStates findLocation $query');

    List<Address>? locations = await Geocoder.local.findAddressesFromQuery(query);

    if(locations != null && locations.length > 0 && locations.first.coordinates != null) {
      Coordinates coordinates = locations.first.coordinates!;
      return LatLng(coordinates.latitude, coordinates.longitude);
    }

    return null;
  }
  
  /// Tries to locate the current user location.
  /// 
  /// Return LatLng location if found, 
  /// and optionally sets the map view to the user's location
  /// (or stay in previous location if geolocation failed).
  Future<LatLng?> locate([bool automove = false, double zoom = 17.0]) async {
    log('MapStates locate');

    _startLocating();

    await _initLocationSettings();
    LocationData? data = await _location?.getLocation();

    _stopLocating();

    if(data != null) {
      _position = LatLng(
        data.latitude, 
        data.longitude, 
        data.altitude,
      );

      notifyListeners();

      if(automove) {
        move(_position, (zoom + 0.01212), true);
        rotate(0.0, true);
      }

      return _position;
    }

    return null;
  }

  @override
  void dispose() {
    log('MapStates dispose');
    _locationSubs?.cancel();
    _positionStream.close();
    super.dispose();
  }
}
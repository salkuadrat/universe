import 'dart:async';
import 'dart:math' as math;
import 'package:curved_animation_controller/curved_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

import '../core/core.dart';
import '../log.dart';
import '../shared.dart';
import 'controller/controller.dart';
import 'interactive/interactive.dart';
import 'options/options.dart';

/// Global Map State
class MapState extends ChangeNotifier {
  late MapController _originalController;
  late MapOptions _originalOptions;

  late MapController _controller;
  late MapOptions _options;
  late LatLng _center;
  late double _zoom;
  late double _minZoom;
  late double _maxZoom;
  late double _originalRotation;
  late double _rotation;
  late Size _size;
  late bool _isLocating;

  LatLng? _position;
  Location? _location;
  StreamSubscription? _locationSubs;
  late StreamController<MapData> _positionStream;
  late StreamController<LatLng> _liveStream;

  late TickerProvider _vsync;
  CurvedAnimationController? _rotateAnim;
  CurvedAnimationController? _moveAnim;
  CurvedAnimationController? _zoomAnim;

  double _angle = 0.0;
  double _angleStart = 0.0;

  Function? _onAngleChanged;
  //Function? _onTileChanged;
  List<Function?> _onChangedListeners = [];

  /// Callback function to be called when tap on this map.
  Function? get onTap => _options.onTap;

  /// Callback function to be called when long press on this map.
  Function? get onLongPress => _options.onLongPress;

  MapState({
    required MapController controller,
    required MapOptions options,
  }) {
    _originalController = controller;
    _originalOptions = options;
    _controller = controller;
    _options = options;
    _zoom = options.zoom;
    _minZoom = options.minZoom;
    _maxZoom = options.maxZoom;
    _originalRotation = options.rotation;
    _rotation = 0.0;
    _size = options.size!;
    _isLocating = false;
    _onChangedListeners = [];

    // prepare for default center when the map uses a string centerQuery
    _center = options.center ?? LatLng(0.0, 0.0);

    _angle = degToRadian(_rotation);
    _controller.onReady = options.onReady;
    _controller.onChanged = options.onChanged;
    _controller.map = this;

    assert(options.slideOnBoundaries ||
        (options.centerQuery != null && options.centerQuery!.isNotEmpty) ||
        (options.center != null && !_isOutOfBounds(options.center)));
  }

  /// Stream to listen to current data position of the map.
  StreamController<MapData> get positionStream => _positionStream;

  /// Stream to listen to current live user position on the map
  StreamController<LatLng> get liveStream => _liveStream;

  /// Map controller.
  MapController get controller => _controller;

  /// Map options.
  MapOptions get options => _options;

  /// Crs of this map.
  Crs get crs => options.crs;

  /// Current center of this map.
  LatLng get center => _center;

  /// Current zoom level of this map.
  double get zoom => _zoom;

  /// Min zoom level.
  double get minZoom => _minZoom;

  /// Max zoom level.
  double get maxZoom => _maxZoom;

  /// Current rotation degrees of this map.
  double get rotation => _rotation;

  /// Original initial rotation of this map.
  double get originalRotation => _originalRotation;

  /// Size of this map.
  Size get size => _size;

  /// Current angle of this map (radian).
  double get angle => _angle;

  /// Initial angle of this map (radian).
  double get angleStart => _angleStart;

  /// Whether the map is currently searching for user location.
  bool get isLocating => _isLocating;

  /// Whether the map is currently not searching user location.
  bool get isNotLocating => !isLocating;

  /// Current user location.
  Location? get location => _location;

  /// Current user position.
  LatLng? get position => _position;

  late SafeBounds _safeBoundsCache;
  //late double _safeBoundsZoom;

  /// Whether max bounds of this map is set.
  bool get hasMaxBounds => _options.hasMaxBounds;

  /// South west bound of this map.
  LatLng? get swBound => _options.maxBounds?.southWest;

  /// North east bound of this map.
  LatLng? get neBound => _options.maxBounds?.northEast;

  /// Whether user can rotate this map.
  bool get canRotate => _options.canRotate;

  /// Whether the map is rotated.
  bool get hasRotation => _rotation > 0.0;

  /// Whether the map is showing center marker.
  bool get showCenterMarker => _options.showCenterMarker;

  /// Whether the map is showing location marker.
  bool get showLocationMarker =>
      _options.showLocationMarker && _position != null;

  /// Center marker of this map.
  dynamic get centerMarker => _options.centerMarker;

  /// Location marker of this map.
  dynamic get locationMarker => _options.locationMarker;

  /// Map width
  double get width => _size.width;

  /// Map height
  double get height => _size.height;

  Size get _halfSize => _size / 2;
  UPoint get _halfPoint => UPoint.from(_halfSize);

  double get _widthInDegrees => _size.width * (360 / math.pow(2, _zoom + 8));
  double get _heightInDegrees =>
      (_size.height * 170.102258) / math.pow(2, _zoom + 8);

  /// Center point of this map.
  UPoint get centerPoint => getCenterPoint(_center, _zoom);

  /// Pixel origin of this map.
  UPoint get pixelOrigin => getPixelOrigin(_center, _zoom);

  /// Calculate center point from LatLng center position and zoom level.
  UPoint getCenterPoint(LatLng? center, [double? zoom]) {
    return project(center, zoom ?? _zoom);
  }

  /// Calculate pixel origin from LatLng center position and zoom level.
  UPoint getPixelOrigin(LatLng? center, [double? zoom]) {
    return (getCenterPoint(center, zoom) - _halfPoint).round();
  }

  /// Get pixel world bounds with a specified zoom.
  Bounds? getPixelWorldBounds(double? zoom) {
    return crs.getProjectedBounds(zoom ?? _zoom);
  }

  /// Current pixel bounds.
  Bounds get pixelBounds => getPixelBounds(_center, _zoom);

  /// Get pixel bounds based on specified center and zoom level.
  Bounds getPixelBounds(LatLng? center, double zoom) {
    double scale = getZoomScale(zoom, _zoom);

    UPoint centerPoint = getCenterPoint(center, zoom).floor();
    UPoint offset = UPoint.from(_halfSize / scale);

    return Bounds(centerPoint - offset, centerPoint + offset);
  }

  /// Bounds of this map.
  LatLngBounds get bounds {
    final bounds = pixelBounds;

    return LatLngBounds(
      unproject(bounds.bottomLeft),
      unproject(bounds.topRight),
    );
  }

  /// Wrap bounds
  LatLngBounds wrapLatLngBounds(LatLngBounds latlngBounds) {
    return crs.wrapLatLngBounds(latlngBounds);
  }

  /// Limit zoom level of this map.
  double limitZoom([double? zoom]) {
    return math.max(minZoom, math.min(maxZoom, zoom ?? _zoom));
  }

  /// Convert latlng position to physical point on screen.
  UPoint project(LatLng? latlng, [double? zoom]) {
    return latlngToPoint(latlng, zoom ?? _zoom);
  }

  /// Convert latlng position to physical point on screen.
  UPoint latlngToPoint(LatLng? latlng, [double? zoom]) {
    return crs.latlngToPoint(latlng, zoom ?? _zoom);
  }

  /// Convert physical point on screen to latlng position on the map.
  LatLng? unproject(UPoint point, [double? zoom]) {
    return pointToLatLng(point, zoom ?? _zoom);
  }

  /// Convert physical point on screen to latlng position on the map.
  LatLng? pointToLatLng(UPoint point, [double? zoom]) {
    return crs.pointToLatLng(point, zoom ?? _zoom);
  }

  /// Convert offset to point
  UPoint offsetToPoint(Offset offset) {
    return UPoint(offset.dx, offset.dy);
  }

  /// Convert point to offset
  Offset pointToOffset(UPoint point) {
    return Offset(point.x, point.y);
  }

  /// Convert offset to size
  Size offsetToSize(Offset offset) {
    return Size(offset.dx, offset.dy);
  }

  /// Convert size to offset
  Offset sizeToOffset(Size size) {
    return Offset(size.width, size.height);
  }

  /// Convert offset to latlng position on the map.
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
  /// from zoom level [fromZoom] to [toZoom].
  ///
  /// Used internally to help with zoom animations.
  double getZoomScale(double toZoom, [double? fromZoom]) {
    return crs.scale(toZoom)! / crs.scale(fromZoom ?? _zoom)!;
  }

  /// Returns the zoom level that the map would end up at,
  /// if it is at [fromZoom] level and everything is scaled
  /// by a factor of [scale].
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

    if (zoom == double.infinity) {
      return MapData(center: bounds.center, zoom: zoom);
    }

    UPoint swPoint = project(bounds.southWest, zoom);
    UPoint nePoint = project(bounds.northEast, zoom);
    UPoint offset = (paddingBR - paddingTL) / 2;

    UPoint centerPoint = ((swPoint + nePoint) / 2) + offset;
    LatLng? center = unproject(centerPoint, zoom);

    return MapData(center: center, zoom: zoom);
  }

  double _getBoundsZoom(LatLngBounds bounds, UPoint padding,
      {bool inside = false}) {
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
    if (hasMaxBounds) {
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
    if (center == null) {
      return true;
    }

    if (hasMaxBounds) {
      if (options.adaptiveBoundaries) {
        return !_safeBounds.contains(center);
      }

      bool isLatOutOfBounds =
          (center.lat < swBound!.lat) || (center.lat > neBound!.lat);

      bool isLngOutOfBounds =
          (center.lng < swBound!.lng) || (center.lng > neBound!.lng);

      if (isLatOutOfBounds || isLngOutOfBounds) {
        return true;
      }
    }

    return false;
  }

  LatLng _safeCenter(LatLng center, LatLng defaultCenter) {
    if (hasMaxBounds) {
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

  void addChangedListener(Function listener) {
    _onChangedListeners.add(listener);
  }

  void _callChangedListeners() {
    for (var listener in _onChangedListeners) {
      listener?.call();
    }
  }

  Future<void> init(TickerProvider vsync, Function onAngleChanged) async {
    log('MapStates init');

    _vsync = vsync;
    _onAngleChanged = onAngleChanged;
    _positionStream = StreamController.broadcast(sync: true);
    _liveStream = StreamController.broadcast(sync: true);

    notifyListeners();

    await _initLocation();

    if (options.hasFitBounds) {
      fitBounds(options.fitBounds, options.fitBoundsOptions);
    } else if (options.hasCenterQuery) {
      await _locateCenter(options.center);
    } else if (options.hasCenter) {
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

  Future<void> _initLocation() async {
    log('MapStates initLocation');

    _location = Location();

    if (options.live) {
      _startLocating();
      _location?.enableBackgroundMode(enable: true);

      await _initLocationSettings();

      _locationSubs = _location?.onLocationChanged.listen((latlng) {
        if (latlng.latitude != null && latlng.longitude != null) {
          _stopLocating();

          _position = LatLng(
            latlng.latitude,
            latlng.longitude,
            latlng.altitude,
          );

          notifyListeners();

          _liveStream.add(_position!);

          if (bounds.north != null &&
              bounds.south != null &&
              bounds.west != null &&
              bounds.east != null) {
            bool isInLatBounds = latlng.latitude! <= bounds.north! &&
                latlng.latitude! >= bounds.south!;
            bool isInLngBounds = latlng.longitude! >= bounds.west! &&
                latlng.longitude! <= bounds.east!;
            bool isInBounds = isInLatBounds && isInLngBounds;
            bool notInBounds = !isInBounds;

            if (notInBounds && options.moveWhenLive) {
              move(_position, 17 - 0.02, true);
            }
          }
        }
      });
    }
  }

  Future<void> _initLocationSettings() async {
    bool serviceEnabled = await _location?.serviceEnabled() ?? false;

    if (!serviceEnabled) {
      serviceEnabled = await _location?.requestService() ?? false;

      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus? permissionGranted = await _location?.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location?.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> _locateCenter([LatLng? defaultCenter]) async {
    log('MapStates locateCenter');

    LatLng? center = await findLocation(options.centerQuery!) ?? defaultCenter;
    double zoom = _zoom;

    if (center != null) {
      _center = center;
      _options = _options.copyWith(center: center);

      rotate(0.0, true);
      await move(_center, zoom - 1.1);
      await move(_center, zoom, true);
    }
  }

  void reset() {
    log('MapStates reset');
    _controller = _originalController;
    _options = _originalOptions;
    notifyListeners();
  }

  void resize(double width, double height) {
    log('MapStates resize');
    _size = Size(width, height);
    notifyListeners();
  }

  void _move(LatLng center, double? zoom) {
    zoom = limitZoom(zoom);

    bool isZoomChanged = _isNotEqualZoom(zoom);
    bool isCenterChanged = _center.notEqual(center);
    bool isMapChanged = isZoomChanged || isCenterChanged;
    bool isMapNotChanged = !isMapChanged;
    bool boundsNotValid = hasMaxBounds && bounds.isNotValid;

    // if not moved (center is not changed or bounds is not valid)
    if (isMapNotChanged || boundsNotValid) {
      return;
    }

    if (_isOutOfBounds(center)) {
      if (!options.slideOnBoundaries) {
        return;
      }

      center = _safeCenter(center, _center);
      isCenterChanged = center.notEqual(_center);
    }

    _center = center;
    _zoom = zoom;
    _rotation = radianToDeg(_angle);

    _callChangedListeners();
    _controller.onChanged?.call(_center, _zoom, _rotation);
    _positionStream.add(MapData(center: _center, zoom: _zoom));

    notifyListeners();
  }

  Future<void> move(dynamic center, double? zoom,
      [bool animate = false]) async {
    log('MapStates move $center $zoom');

    if (center is String) {
      center = await findLocation(center);
    } else {
      center = LatLng.from(center);
    }

    if (center == null) {
      return;
    }

    if (animate) {
      _moveAnim = CurvedAnimationController.tween(
        LatLngTween(begin: _center, end: center),
        const Duration(milliseconds: 300),
        curve: Curves.ease,
        vsync: _vsync,
      );

      _zoomAnim = CurvedAnimationController(
        begin: _zoom,
        end: zoom,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
        vsync: _vsync,
      );

      _moveAnim?.addListener(() {
        _move(_moveAnim!.value, _zoom);
      });

      _zoomAnim?.addListener(() {
        _zoom = _zoomAnim!.value;
      });

      _moveAnim?.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _moveAnim?.dispose();
        }
      });

      _zoomAnim?.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _zoomAnim?.dispose();
        }
      });

      _moveAnim
        ?..reset()
        ..start();
      _zoomAnim
        ?..reset()
        ..start();
    } else {
      _move(center, zoom);
    }
  }

  void fitBounds(dynamic bounds, [FitBoundsOptions? options]) {
    log('MapStates fitBounds');

    LatLngBounds latlngBounds = LatLngBounds.from(bounds);

    if (latlngBounds.isNotValid) {
      throw Exception('Bounds are not valid');
    }

    final target =
        _getBoundsCenterZoom(latlngBounds, options ?? const FitBoundsOptions());

    move(target.center, target.zoom, true);
  }

  void fitWorld([FitBoundsOptions? options]) {
    log('MapStates fitWorld');
    fitBounds([
      [-90.0, -180.0],
      [90.0, 180.0]
    ], options);
  }

  set minZoom(double minZoom) {
    _minZoom = minZoom;
    notifyListeners();

    if (_zoom < minZoom) {
      zoomTo(minZoom);
    }
  }

  set maxZoom(double maxZoom) {
    _maxZoom = maxZoom;
    notifyListeners();

    if (_zoom > maxZoom) {
      zoomTo(maxZoom);
    }
  }

  void zoomIn([double zoomDelta = zoomDeltaDef]) {
    zoomTo(_zoom + zoomDelta);
  }

  void zoomOut([double zoomDelta = zoomDeltaDef]) {
    zoomTo(_zoom - zoomDelta);
  }

  void zoomTo(double zoom, [bool animate = false]) {
    log('MapStates zoomTo $zoom');

    if (animate) {
      _zoomAnim = CurvedAnimationController(
        begin: _zoom,
        end: zoom,
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
        vsync: _vsync,
      );

      _zoomAnim?.addListener(() {
        _move(_center, _zoomAnim!.value);
      });

      _zoomAnim?.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _zoomAnim?.dispose();
        }
      });

      _zoomAnim
        ?..reset()
        ..start();
    } else {
      _move(_center, zoom);
    }
  }

  void zoomAround(dynamic position, double zoom) {
    UPoint halfSize = UPoint.from(_halfSize);
    UPoint containerPoint;

    double scale = getZoomScale(zoom);

    if (position is UPoint) {
      containerPoint = position;
    } else if (position is LatLng) {
      containerPoint = latlngToPoint(position);
    } else {
      position = LatLng.from(position);
      containerPoint = latlngToPoint(position);
    }

    UPoint offset = (containerPoint - halfSize) * (1 - (1 / scale));
    LatLng? center = pointToLatLng(halfSize + offset);
    move(center, zoom);
  }

  set angle(angle) {
    _angle = angle;
    _rotation = radianToDeg(_angle);
    _onAngleChanged?.call();
    _callChangedListeners();
    notifyListeners();
  }

  set rotation(rotation) {
    _rotation = rotation;
    _angle = degToRadian(_rotation);
    _onAngleChanged?.call();
    _callChangedListeners();
    notifyListeners();
  }

  set angleStart(angleStart) {
    _angleStart = angleStart;
    notifyListeners();
  }

  void rotate(
    double rotateTo, [
    bool animate = false,
    Function? onAnimateEnd,
  ]) {
    log('MapStates rotate $rotateTo');

    if (animate) {
      _rotateAnim = CurvedAnimationController(
        begin: normalizeDeg(_rotation),
        end: normalizeDeg(rotateTo),
        vsync: _vsync,
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
      );

      _rotateAnim?.addListener(() {
        rotation = _rotateAnim!.value;
      });

      _rotateAnim?.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          onAnimateEnd?.call();
          _rotateAnim?.dispose();
        }
      });

      _rotateAnim
        ?..reset()
        ..start();
    } else {
      rotation = rotateTo;
    }
  }

  // Find LatLng from location address
  Future<LatLng?> findLocation(String address) async {
    log('MapStates findLocation $address');

    GeoCode geoCode = GeoCode();

    try {
      Coordinates coordinates = await geoCode.forwardGeocoding(
        address: address,
      );
      return LatLng(coordinates.latitude, coordinates.longitude);
    } catch (e) {
      log(e);
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

    try {
      LocationData? data = await _location?.getLocation();
      _stopLocating();

      if (data != null) {
        _position = LatLng(
          data.latitude,
          data.longitude,
          data.altitude,
        );

        notifyListeners();

        if (automove) {
          await move(_position, zoom - 0.02, true);
        }

        return _position;
      }
    } catch (e) {
      _stopLocating();
      log(e);
    }

    return null;
  }

  /// close map state
  void close() {
    _locationSubs?.cancel();
    _positionStream.close();
    _liveStream.close();
  }

  /// dispose map state
  @override
  void dispose() {
    log('MapStates dispose');
    super.dispose();
  }
}

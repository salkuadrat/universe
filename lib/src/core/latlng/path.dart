import 'dart:math';

import 'package:logging/logging.dart';
import 'package:validate/validate.dart';

import '../../shared.dart';
import 'distance/distance.dart';
import 'latlng.dart';
import 'spline/catmullrom.dart';

typedef LatLng GeoPositionFactory(double lat, double lng);

LatLng _defGeoPositionFactory(double lat, double lng) => 
  LatLng(lat, lng);

/// Path of [GeoPosition] values
///
/// If you use [Path] with Generics - check out this sample:
///
/// class Location extends LatLng {
///   ....
/// }
///
/// Path<Location> path = new Path<Location>(factory: locationFactory);
///
class Path<T extends LatLng> {

  Logger _logger = Logger('universe.Path');

  // Path coordinates
  List<T> coordinates;
  final GeoPositionFactory geoPositionFactory;
  final Distance getDistance;

  Path({this.geoPositionFactory=_defGeoPositionFactory, this.getDistance=const Distance()}) 
    : coordinates = List<T>();

  Path.from(this.coordinates, {
    this.geoPositionFactory=_defGeoPositionFactory, 
    this.getDistance=const Distance(),
  }) {
    Validate.notNull(coordinates);
  }

  /// Removes all coordinates from path
  void clear() => coordinates.clear();

  /// Add new [T] coordinate to path
  void add(final T value) {
    Validate.notNull(value);
    coordinates?.add(value);
  }
  
  /// Add all coordinates from [List<T>] to path
  void addAll(final List<T> values) {
    Validate.notNull(values);
    coordinates?.addAll(values);
  }
  
  T get first => coordinates?.first;
  T get last => coordinates?.last;

  /// Sums up all the distances on the path
  /// 
  /// Path path = new Path.from(route);
  /// print(path.distance);
  ///
  double get distance {
    List<T> coords = coordinates.toList();
    double length = 0.0;
    
    for(int index = 0;index < coords.length - 1;index++) {
      length += getDistance(coords[index], coords[index + 1]);
    }
    
    return round(length);
  }

  /// Calculates the center of a collection of geo coordinates
  /// 
  /// The function rounds the result to 6 decimals
  /// 
  LatLng get center {
    Validate.notEmpty(coordinates, "Coordinates must not be empty!");

    double X = 0.0;
    double Y = 0.0;
    double Z = 0.0;

    coordinates.forEach((coordinate) {  
      double lat = coordinate.latitudeInRad;
      double lng = coordinate.longitudeInRad;

      X += cos(lat) * cos(lng);
      Y += cos(lat) * sin(lng);
      Z += sin(lat);
    });
    
    int numCoordinates = coordinates.length;
    X = X / numCoordinates;
    Y = Y / numCoordinates;
    Z = Z / numCoordinates;

    double hyp = sqrt(X * X + Y * Y);
    double latitude = atan2(Z, hyp);
    double longitude = atan2(Y, X);

    latitude = round(radianToDeg(latitude));
    longitude = round(radianToDeg(longitude));

    return geoPositionFactory(latitude, longitude);
  }

  /// Returns the number of coordinates
  /// 
  /// Path path = new Path.from(<LatLng>[ start, end ]);
  /// int n = path.numCoordinates; // n == 2
  ///
  int get numCoordinates => coordinates.length;

  /// Returns the [LatLng] coordinate form [index]
  /// 
  /// Path path = new Path.from(<LatLng>[ start, end ]);
  /// LatLng p = path[0]; // p == start
  ///
  T operator[](int index) => coordinates.elementAt(index);

  /// Splits the path into even sections.
  ///
  /// The section size is defined with [distanceInMeterPerTime].
  /// [distanceInMeterPerTime] means that the original size on the given
  /// path will stay the same but the created section could be smaller because of the "linear distance"
  ///
  /// However - if you follow the steps in a given time then the distance from point to point (over time)
  /// is correct. (Almost - because of the curves generate with [CatmullRomSpline2D]
  ///
  /// Path path = new Path.from(zigzag);
  ///
  /// If [smoothPath] is turned on than the minimum of 3 coordinates is required 
  /// otherwise we need two
  Path equalize(final num distanceInMeterPerTime,{ final bool smoothPath: true }) {
    
    Validate.isTrue(distanceInMeterPerTime > 0, "Distance must be greater than 0");
    
    Validate.isTrue(
      (smoothPath && coordinates.length >= 3) || (!smoothPath&& coordinates.length >= 2), 
      "At least ${smoothPath ? 3 : 2} coordinates are needed to create the steps in between");
    
    // If we "smooth" the path every second step becomes a spline - so every other step
    // becomes a "Keyframe". A step on the given path
    double stepDistance = smoothPath ? distanceInMeterPerTime * 2.0 : distanceInMeterPerTime.toDouble();
    double baseLength = distance;
    
    Validate.isTrue(baseLength >= stepDistance,
      "Path distance must be at least ${stepDistance}m (step distance) but was $baseLength");
    
    if(stepDistance > baseLength / 2) {
      _logger.warning(
        "Equalizing the path (L: $baseLength) with a key-frame distance of $stepDistance leads to"
        "weired results. Turn of path smooting.");
    }
    
    // no steps possible - so return an empty path
    if(baseLength == stepDistance) {
      return Path.from([ coordinates.first, coordinates.last ]);
    }
    
    List<T> tempCoordinates = coordinates.toList();
    Path path = Path();
    
    double remainingSteps = 0.0;
    double bearing;
    
    path.add(tempCoordinates.first);
    T baseStep = tempCoordinates.first;
    
    for(int index = 0;index < coordinates.length - 1;index++) {
      double distance = getDistance(tempCoordinates[index],tempCoordinates[index + 1]);
      
      // Remember the direction
      bearing = getDistance.bearing(tempCoordinates[index],tempCoordinates[index + 1]);
      
      if(remainingSteps <= distance || (stepDistance - remainingSteps) <= distance) {
        // First step position
        double firstStepPos = stepDistance - remainingSteps;
        double steps = ((distance - firstStepPos) / stepDistance) + 1;
        int fullSteps = steps.toInt();
        
        remainingSteps = round(fullSteps > 0 ? steps % fullSteps : steps,decimals: 6) * stepDistance;
        baseStep = tempCoordinates[index];
        
        for(int stepCounter = 0; stepCounter < fullSteps;stepCounter++) {
          // Add step on the given path
          // Intermediate step is necessary to stay type-safe
          LatLng tempStep = getDistance.offset(baseStep,firstStepPos,bearing);
          LatLng nextStep = geoPositionFactory(tempStep.latitude,tempStep.longitude);
          path.add(nextStep);
          
          firstStepPos += stepDistance;
          
          if(smoothPath) {
            // Now - split it
            CatmullRomSpline2D<double> spline;
            
            if(path.numCoordinates == 3) {
              spline = _createSpline(path[0],path[0],path[1],path[2]);
              
              // Insert new point between 0 and 1
              path.coordinates.insert(1, _pointToPosition(spline.percentage(50)));
            
            } else if(path.numCoordinates > 3) {
              int baseIndex = path.numCoordinates - 1;
              spline = _createSpline(
                path[baseIndex - 3], 
                path[baseIndex - 2], 
                path[baseIndex - 1], 
                path[baseIndex],
              );
              
              // Insert new point at last position - 2 (pushes the next 2 items down)
              path.coordinates.insert(baseIndex - 1, _pointToPosition(spline.percentage(50)));
            }
          }
        }
      } else {
        remainingSteps += distance;
      }
    }
    
    // If last step is on the same position as the last generated step
    // then don't add the last base step.
    if(baseStep.round() != tempCoordinates.last.round() &&
       baseStep.round() != tempCoordinates.first.round() &&
       round(getDistance(baseStep,tempCoordinates.last)) > 1) {
      path.add(tempCoordinates.last);
    }
    
    if(smoothPath) {
      // Last Spline between the last 4 elements
      int baseIndex = path.numCoordinates - 1;
      
      if(baseIndex > 3) {
        CatmullRomSpline2D<double> spline = _createSpline(
          path[baseIndex - 3], 
          path[baseIndex - 2], 
          path[baseIndex - 1], 
          path[baseIndex - 0],
        );
        
        path.coordinates.insert(baseIndex - 1, _pointToPosition(spline.percentage(50)));
      }
      
      // Check if there is a remaining gap between the last two elements - close it
      // Could be because of reminder from path divisions
      baseIndex = path.numCoordinates - 1;
      if(getDistance(path[baseIndex - 1], path[baseIndex]) >= stepDistance) {
        CatmullRomSpline2D<double> spline = _createSpline(
          path[baseIndex - 1], 
          path[baseIndex - 1], 
          path[baseIndex - 0], 
          path[baseIndex - 0],
        );
        
        path.coordinates.insert(baseIndex, _pointToPosition(spline.percentage(50)));
      }
    }
    
    return path;
  }
  
  /// 4 Points are necessary to create a [CatmullRomSpline2D]
  CatmullRomSpline2D<double> _createSpline(LatLng p0, LatLng p1, LatLng p2, LatLng p3) {
    Validate.notNull(p0);
    Validate.notNull(p1);
    Validate.notNull(p2);
    Validate.notNull(p3);

    return CatmullRomSpline2D(
      Point2D(p0.latitude,p0.longitude),
      Point2D(p1.latitude,p1.longitude),
      Point2D(p2.latitude,p2.longitude),
      Point2D(p3.latitude,p3.longitude)
    );
  }
  
  /// Convert [Point2D] to [LatLng]
  LatLng _pointToPosition(Point2D point) => geoPositionFactory(point.x,point.y);
}
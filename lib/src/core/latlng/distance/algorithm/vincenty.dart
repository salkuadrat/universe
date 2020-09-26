import 'dart:math';

import '../../../../shared.dart';
import '../../latlng.dart';
import '../distance.dart';


class Vincenty implements DistanceAlgorithm {

  const Vincenty();

  @override
  double distance(LatLng position, LatLng destination) {
    
    double a = EQUATOR_RADIUS, b = POLAR_RADIUS, f = FLATTENING;
    double L = destination.longitudeInRad - position.longitudeInRad;
    double u1 = atan((1 - f) * tan(position.latitudeInRad));
    double u2 = atan((1 - f) * tan(destination.latitudeInRad));

    double sinU1 = sin(u1), cosU1 = cos(u1);
    double sinU2 = sin(u2), cosU2 = cos(u2);

    double sinLambda, cosLambda, sinSigma, cosSigma, sigma, sinAlpha, cosSqAlpha, cos2SigmaM;
    double lambda = L, lambdaP;
    int maxIterations = 200;
    
    do {
      sinLambda = sin(lambda);
      cosLambda = cos(lambda);
      sinSigma = sqrt(
        (cosU2 * sinLambda) * (cosU2 * sinLambda) + 
        (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda) * 
        (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda)
      );
      
      if(sinSigma == 0) {
        return 0.0; // co-incident points
      }

      cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda;
      sigma = atan2(sinSigma, cosSigma);
      sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma;
      cosSqAlpha = 1 - sinAlpha * sinAlpha;
      cos2SigmaM = cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha;

      if(cos2SigmaM.isNaN) {
        cos2SigmaM = 0.0; // equatorial line: cosSqAlpha=0 (§6)
      }
      
      double C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha));
      lambdaP = lambda;
      lambda = 
        L + (1 - C) * f * sinAlpha * 
        (sigma + C * sinSigma * (cos2SigmaM + C * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));
    
    } while ((lambda - lambdaP).abs() > 1e-12 && --maxIterations > 0);

    if (maxIterations == 0) {
      throw new StateError("Distance calculation faild to converge!");
    }
    
    double uSq = cosSqAlpha * (a * a - b * b) / (b * b);
    double A = 1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
    double B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));
    double deltaSigma = B * sinSigma * 
      (cos2SigmaM + B / 4 * 
        (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) - B / 6 * cos2SigmaM * 
        (-3 + 4 * sinSigma * sinSigma) * (-3 + 4 * cos2SigmaM * cos2SigmaM)));

    double distance = b * A * (sigma - deltaSigma);
    return distance;
  }

  @override
  LatLng offset(LatLng from, double distanceInMeter, double bearing) {

    double equatorialRadius = EQUATOR_RADIUS;
    double polarRadius = POLAR_RADIUS;
    double flattening = FLATTENING;

    double alpha1 = degToRadian(bearing);
    double sinAlpha1 = sin(alpha1);
    double cosAlpha1 = cos(alpha1);

    double tanU1 = (1 - flattening) * tan(from.latitude);
    double cosU1 = 1 / sqrt((1 + tanU1 * tanU1));
    double sinU1 = tanU1 * cosU1;

    double sigma1 = atan2(tanU1, cosAlpha1);
    double sinAlpha = cosU1 * sinAlpha1;
    double cosSqAlpha = 1 - sinAlpha * sinAlpha;
    double dfUSq = 
      cosSqAlpha * (equatorialRadius * equatorialRadius - polarRadius * polarRadius) / 
      (polarRadius * polarRadius);

    double a = 1 + dfUSq / 16384 * (4096 + dfUSq * (-768 + dfUSq * (320 - 175 * dfUSq)));
    double b = dfUSq / 1024 * (256 + dfUSq * (-128 + dfUSq * (74 - 47 * dfUSq)));

    double sigma = distanceInMeter / (polarRadius * a);
    double sigmaP = 2 * PI;

    double sinSigma = 0.0;
    double cosSigma = 0.0;
    double cos2SigmaM = 0.0;
    double deltaSigma;
    int maxIterations = 200;

    do {
      cos2SigmaM = cos(2 * sigma1 + sigma);
      sinSigma = sin(sigma);
      cosSigma = cos(sigma);
      
      deltaSigma = 
        b * sinSigma * (cos2SigmaM + b / 4 * (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) -
        b / 6 * cos2SigmaM * (-3 + 4 * sinSigma * sinSigma) *
        (-3 + 4 * cos2SigmaM * cos2SigmaM)));
      
      sigmaP = sigma;
      sigma = distanceInMeter / (polarRadius * a) + deltaSigma;
    
    } while((sigma - sigmaP).abs() > 1e-12 && --maxIterations > 0);

    if (maxIterations == 0) {
      throw new StateError("offset calculation faild to converge!");
    }
    
    double tmp = sinU1 * sinSigma - cosU1 * cosSigma * cosAlpha1;
    double latitude = atan2(
      sinU1 * cosSigma + cosU1 * sinSigma * cosAlpha1, 
      (1 - flattening) * sqrt(sinAlpha * sinAlpha + tmp * tmp),
    );
    
    double lambda = atan2(sinSigma * sinAlpha1, cosU1 * cosSigma - sinU1 * sinSigma * cosAlpha1);
    double c = flattening / 16 * cosSqAlpha * (4 + flattening * (4 - 3 * cosSqAlpha));
    double l = 
      lambda - (1 - c) * flattening * sinAlpha * 
      (sigma + c * sinSigma * (cos2SigmaM + c * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));
      
    double longitude = from.longitude + l;
    
    if (longitude > PI) {
      longitude = longitude - 2 * PI;
    }
    
    if (longitude < -1 * PI) {
      longitude = longitude + 2 * PI;
    }
    
    return LatLng(radianToDeg(latitude), radianToDeg(longitude));
  }
  
}
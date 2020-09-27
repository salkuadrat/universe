// Length of unit relative to meter
class LengthUnit {
  static const LengthUnit MM = const LengthUnit(1000.0); 
  static const LengthUnit CM = const LengthUnit(100.0);
  static const LengthUnit M = const LengthUnit(1.0);
  static const LengthUnit KM = const LengthUnit(0.001);
  static const LengthUnit MILE = const LengthUnit(0.0006213712);

  final double scaleToMeter;

  const LengthUnit(this.scaleToMeter);

  double to(LengthUnit unit, num value) {
    // don't need to convert if the same scale unit
    if(unit.scaleToMeter == scaleToMeter) {
      return value;
    }

    // convert to the desired length unit
    return unit.scaleToMeter * (value / scaleToMeter);
  }
}
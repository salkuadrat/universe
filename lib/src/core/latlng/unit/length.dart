// Length of unit relative to meter
// ignore_for_file: constant_identifier_names

class LengthUnit {
  static const LengthUnit MM = LengthUnit(1000.0);
  static const LengthUnit CM = LengthUnit(100.0);
  static const LengthUnit M = LengthUnit(1.0);
  static const LengthUnit KM = LengthUnit(0.001);
  static const LengthUnit MILE = LengthUnit(0.0006213712);

  final double scaleToMeter;

  const LengthUnit(this.scaleToMeter);

  double to(LengthUnit unit, num value) {
    // don't need to convert if the same scale unit
    if (unit.scaleToMeter == scaleToMeter) {
      return value as double;
    }

    // convert to the desired length unit
    return unit.scaleToMeter * (value / scaleToMeter);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class FreemapSKMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.FreeMapSK(
      center: [51.555158, -0.108343],
      zoom: 16,
    );
  }
}

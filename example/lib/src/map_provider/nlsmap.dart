import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe/universe.dart';

class NLSMap extends StatelessWidget {
  const NLSMap({super.key});

  @override
  Widget build(BuildContext context) {
    return U.NLSMap(
      center: [51.555158, -0.108343],
      zoom: 16,
    );
  }
}

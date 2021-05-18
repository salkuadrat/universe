import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class WidgetOverlayMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return U.OpenStreetMap(
      center: [-6.170039, 106.8241],
      zoom: 16,
      showLocator: true,
      layers: [
        U.WidgetOverlay(
          bounds: [
            [-6.17098, 106.825514],
            [-6.167775, 106.822867],
          ],
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                'Wanna bicycle?',
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ),
        )
      ],
      onTap: print,
    );
  }
}

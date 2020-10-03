import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../map/map.dart';
import '../../base/layer.dart';
import 'marker.dart';

class LocatorLayer extends MapLayer {

  final Locator locator;

  LocatorLayer(this.locator);

  @override 
  Widget buildLayer(BuildContext context, MapController controller, MapState map) {
    if(!locator.hasImage && !locator.hasIcon) {
      return Container();
    }

    return Positioned.fill(
      child: Align(
        alignment: locator.alignment,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: FloatingActionButton(
            onPressed: () => controller?.locate(),
            backgroundColor: Colors.white,
            child: LayoutBuilder(
              builder: (_, __) {
                if(locator.hasImage) return locator.image;
                return Icon(
                  locator.icon, 
                  color: Colors.blueGrey[600], 
                  size: 25,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
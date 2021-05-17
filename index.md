Inspired by the simplicity of Leaflet.js, we can add maps functionality to our flutter project with as simple as adding this lines of code:

```
import 'package:universe/universe.dart';
```

```
U.OpenStreetMap(
  center: [-6.175329, 106.827253],
  type: OpenStreetMapType.HOT,
  zoom: 15,
)
```

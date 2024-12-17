import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_tutorial_template/consts.dart';

class MapPage extends StatelessWidget {
  const MapPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter:
              LatLng(51.509364, -0.128928), // Center the map over London
          initialZoom: 5.2,
          interactionOptions: InteractionOptions(
            flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          ),
          cameraConstraint: CameraConstraint.contain(
            bounds: LatLngBounds(
              LatLng(-90, -180.0),
              LatLng(90.0, 180.0),
            ),
          ),
        ),
        children: [
          TileLayer(
            // Display map tiles from any source
            urlTemplate:
                // 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                'https://tiles.stadiamaps.com/tiles/stamen_toner/{z}/{x}/{y}.jpg?api_key=$stadiaApiKey',

            userAgentPackageName: 'com.example.app',
            // And many more recommended properties!
          ),
        ],
      ),
    );
  }
}

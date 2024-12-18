import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_tutorial_template/consts.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Map'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
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
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(51.50853, -0.12574),
                    width: 60,
                    height: 60,
                    child: MyMarker(),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: CenterButton(
                onPressed: () {
                  mapController.move(LatLng(51.50853, -0.12574), 8);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyMarker extends StatelessWidget {
  const MyMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.redAccent,
        ),
        child: Icon(
          Icons.person_outline_rounded,
          size: 42,
        ),
      ),
    );
  }
}

class CenterButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CenterButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            return Colors.redAccent;
          },
        ),
      ),
      child: Text(
        'Center',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

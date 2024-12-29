import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_tutorial_template/consts.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';
import 'package:stroke_text/stroke_text.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  late final AnimatedMapController animatedMapController;

  @override
  void dispose() {
    animatedMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animatedMapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
      curve: Curves.easeInOut,
      cancelPreviousAnimations: true, // Default to false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: StrokeText(
          text: 'Flutter Map',
          textStyle: TextStyle(fontSize: 30, color: Colors.white),
          strokeColor: Colors.blueAccent,
          strokeWidth: 3,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SoftEdgeBlur(
        edges: [
          EdgeBlur(
            type: EdgeType.topEdge,
            size: 140,
            sigma: 30,
            controlPoints: [
              ControlPoint(
                position: 0.3,
                type: ControlPointType.visible,
              ),
              ControlPoint(
                position: 0.8,
                type: ControlPointType.visible,
              ),
              ControlPoint(
                position: 1,
                type: ControlPointType.transparent,
              )
            ],
          )
        ],
        child: Stack(
          children: [
            FlutterMap(
              mapController: animatedMapController.mapController,
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
                      'https://tiles.stadiamaps.com/tiles/stamen_watercolor/{z}/{x}/{y}.jpg?api_key=$stadiaApiKey',

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
                    animatedMapController.animateTo(
                      dest: LatLng(51.50853, -0.12574),
                      zoom: 8.0,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyMarker extends StatefulWidget {
  const MyMarker({super.key});

  @override
  State<MyMarker> createState() => _MyMarkerState();
}

class _MyMarkerState extends State<MyMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = Tween<double>(begin: 30, end: 45).animate(controller);
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: Icon(
        Icons.person_outline_rounded,
        size: animation.value * 0.7,
      ),
      builder: (context, child) {
        return Center(
          child: Container(
              width: animation.value,
              height: animation.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent,
              ),
              child: child),
        );
      },
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

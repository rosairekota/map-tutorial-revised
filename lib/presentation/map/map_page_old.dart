//# soft_edge_blur: ^0.1.3
//# stroke_text: ^0.0.3

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:map_tutorial_template/application/location/location_cubit.dart';
// import 'package:map_tutorial_template/application/permission/permission_cubit.dart';
// import 'package:map_tutorial_template/consts.dart';
// import 'package:soft_edge_blur/soft_edge_blur.dart';
// import 'package:stroke_text/stroke_text.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   final mapController = MapController();
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<PermissionCubit, PermissionState>(
//           listenWhen: (p, c) {
//             return p.isLocationPermissionGrantedAndServicesEnabled !=
//                     c.isLocationPermissionGrantedAndServicesEnabled &&
//                 c.isLocationPermissionGrantedAndServicesEnabled;
//           },
//           listener: (context, state) {
//             if (Navigator.of(context).canPop()) {
//               Navigator.of(context).pop();
//             }
//           },
//         ),
//         // BlocListener<PermissionCubit, PermissionState>(
//         //   listenWhen: (p, c) =>
//         //       p.displayOpenAppSettingsDialog !=
//         //           c.displayOpenAppSettingsDialog &&
//         //       c.displayOpenAppSettingsDialog,
//         //   listener: (context, state) {
//         //     showDialog(
//         //       context: context,
//         //       builder: (BuildContext context) {
//         //         return AlertDialog(
//         //           shape: RoundedRectangleBorder(
//         //             borderRadius: BorderRadius.circular(15.0),
//         //           ),
//         //           content: AppSettingsDialog(
//         //             openAppSettings: () {
//         //               debugPrint("Open App Settings pressed!");
//         //               context.read<PermissionCubit>().openApplicationSettings();
//         //             },
//         //             cancelDialog: () {
//         //               debugPrint("Cancel pressed!");
//         //               context
//         //                   .read<PermissionCubit>()
//         //                   .hideOpenAppSettingsDialog();
//         //             },
//         //           ),
//         //         );
//         //       },
//         //     );
//         //   },
//         // ),
//         // BlocListener<PermissionCubit, PermissionState>(
//         //   listenWhen: (p, c) =>
//         //       p.displayOpenAppSettingsDialog !=
//         //           c.displayOpenAppSettingsDialog &&
//         //       !c.displayOpenAppSettingsDialog,
//         //   listener: (context, state) {
//         //     Navigator.of(context).pop();
//         //   },
//         // ),
//       ],
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           title: StrokeText(
//             text: "Flutter Map Tutorial",
//             textStyle: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//             strokeColor: Colors.black54,
//             strokeWidth: 3,
//           ),
//           actions: [
//             DropdownButton<String>(items: [
//               DropdownMenuItem(
//                 child: Text('watercolor'),
//               ),
//             ], onChanged: (text) {}),
//           ],
//           backgroundColor: Colors.transparent,
//         ),
//         body: SoftEdgeBlur(
//           edges: [
//             EdgeBlur(
//               type: EdgeType.topEdge,
//               size: 100,
//               sigma: 20,
//               controlPoints: [
//                 ControlPoint(
//                   position: 0.5,
//                   type: ControlPointType.visible,
//                 ),
//                 ControlPoint(
//                   position: 1,
//                   type: ControlPointType.transparent,
//                 )
//               ],
//             )
//           ],
//           child: Stack(
//             children: [
//               Center(
//                 child: BlocBuilder<LocationCubit, LocationState>(
//                   buildWhen: (p, c) {
//                     return p.userLocation != c.userLocation;
//                   },
//                   builder: (context, locationState) {
//                     return FlutterMap(
//                       mapController: mapController,
//                       options: MapOptions(
//                         initialCenter: LatLng(51.509, -0.128),
//                         initialZoom: 3.0,
//                         interactionOptions: InteractionOptions(
//                           flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
//                         ),
//                         cameraConstraint: CameraConstraint.contain(
//                           bounds: LatLngBounds(
//                             LatLng(-90, -180.0),
//                             LatLng(90.0, 180.0),
//                           ),
//                         ),
//                       ),
//                       children: [
//                         TileLayer(
//                           urlTemplate:
//                               //'https://stamen-tiles.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.png',
//                               // 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                               // 'https://tiles.stadiamaps.com/tiles/stamen_watercolor/{z}/{x}/{y}.jpg?api_key=$stadiaApiKey',
//                               'https://tiles.stadiamaps.com/tiles/stamen_toner/{z}/{x}/{y}.jpg?api_key=$stadiaApiKey',
//                           userAgentPackageName: 'com.example.map_tutorial',
//                         ),
//                         MarkerLayer(
//                           markers: [
//                             if (locationState.userLocation != null)
//                               Marker(
//                                 point: LatLng(
//                                     locationState.userLocation!.latitude,
//                                     locationState.userLocation!.longitude),
//                                 width: 60,
//                                 height: 60,
//                                 child: const UserMarker(),
//                               ),
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               BlocSelector<PermissionCubit, PermissionState, bool>(
//                 selector: (state) {
//                   return state.isLocationPermissionGrantedAndServicesEnabled;
//                 },
//                 builder:
//                     (context, isLocationPermissionGrantedAndServicesEnabled) {
//                   return isLocationPermissionGrantedAndServicesEnabled
//                       ? const SizedBox.shrink()
//                       : const Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Padding(
//                             padding: EdgeInsets.only(bottom: 30),
//                             child: LocationButton(),
//                           ),
//                         );
//                 },
//               ),
//               BlocBuilder<LocationCubit, LocationState>(
//                 buildWhen: (p, c) {
//                   return (p.userLocation == null && c.userLocation != null) ||
//                       (p.userLocation != null && c.userLocation == null);
//                 },
//                 builder: (context, state) {
//                   return state.userLocation == null
//                       ? const SizedBox.shrink()
//                       : Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Padding(
//                             padding: EdgeInsets.only(bottom: 30),
//                             child: CenterButton(
//                               onPressed: () {
//                                 mapController.move(
//                                   LatLng(state.userLocation!.latitude,
//                                       state.userLocation!.longitude),
//                                   mapController.camera.zoom,
//                                 );
//                               },
//                             ),
//                           ),
//                         );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class UserMarker extends StatefulWidget {
//   const UserMarker({super.key});

//   @override
//   State<UserMarker> createState() => _UserMarkerState();
// }

// class _UserMarkerState extends State<UserMarker>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation<double> sizeAnimation;

//   @override
//   void initState() {
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     sizeAnimation = Tween<double>(
//       begin: 45,
//       end: 60,
//     ).animate(CurvedAnimation(
//         parent: animationController, curve: Curves.fastOutSlowIn));
//     animationController.repeat(
//       reverse: true,
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: sizeAnimation,
//       builder: (context, child) {
//         return Center(
//           child: Container(
//             width: sizeAnimation.value,
//             height: sizeAnimation.value,
//             decoration: const BoxDecoration(
//               color: Colors.black,
//               shape: BoxShape.circle,
//             ),
//             child: child,
//           ),
//         );
//       },
//       child: const Icon(
//         Icons.person_pin,
//         color: Colors.white,
//         size: 35,
//       ),
//     );
//   }
// }

// class CenterButton extends StatelessWidget {
//   final Function onPressed;
//   const CenterButton({
//     super.key,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor: WidgetStateProperty.resolveWith<Color?>(
//           (Set<WidgetState> states) {
//             return Colors.black;
//           },
//         ),
//       ),
//       onPressed: () {
//         debugPrint("Center button Pressed!");

//         onPressed();
//       },
//       child: const Text("Center"),
//     );
//   }
// }

// class LocationButton extends StatelessWidget {
//   const LocationButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       // style: ButtonStyle(
//       //   backgroundColor: WidgetStateProperty.resolveWith<Color?>(
//       //     (Set<WidgetState> states) {
//       //       return Colors.black;
//       //     },
//       //   ),
//       // ),
//       onPressed: () {
//         debugPrint("Location Services button Pressed!");

//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             final bool isLocationPermissionGranted = context.select(
//                 (PermissionCubit element) =>
//                     element.state.isLocationPermissionGranted);
//             final bool isLocationServicesEnabled = context.select(
//                 (PermissionCubit element) =>
//                     element.state.isLocationServiceEnabled);
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               content: PermissionDialog(
//                 isLocationPermissionGranted: isLocationPermissionGranted,
//                 isLocationServicesEnabled: isLocationServicesEnabled,
//               ),
//             );
//           },
//         );
//       },
//       child: const Text("Request Location Permission"),
//     );
//   }
// }

// class PermissionDialog extends StatelessWidget {
//   final bool isLocationPermissionGranted;
//   final bool isLocationServicesEnabled;
//   const PermissionDialog({
//     super.key,
//     required this.isLocationPermissionGranted,
//     required this.isLocationServicesEnabled,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 10),
//         const Text(
//             "Please allow location permission and services to view your location:)"),
//         const SizedBox(height: 15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("Location Permission: "),
//             TextButton(
//               onPressed: isLocationPermissionGranted
//                   ? null
//                   : () {
//                       debugPrint("Location permission button pressed!");
//                       context
//                           .read<PermissionCubit>()
//                           .requestLocationPermission();
//                     },
//               child: Text(isLocationPermissionGranted ? "allowed" : "allow"),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("Location Services: "),
//             TextButton(
//               onPressed: isLocationServicesEnabled
//                   ? null
//                   : () {
//                       debugPrint("Location services button pressed!");
//                       context.read<PermissionCubit>().openLocationSettings();
//                     },
//               child: Text(isLocationServicesEnabled ? "allowed" : "allow"),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }

// class AppSettingsDialog extends StatelessWidget {
//   final Function openAppSettings;
//   final Function cancelDialog;
//   const AppSettingsDialog({
//     super.key,
//     required this.openAppSettings,
//     required this.cancelDialog,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 10),
//         const Text(
//             "You need to open app settings to grant Location Permission"),
//         const SizedBox(height: 15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             TextButton(
//               onPressed: () {
//                 openAppSettings();
//               },
//               child: const Text("Open App Settings"),
//             ),
//             TextButton(
//               onPressed: () {
//                 cancelDialog();
//               },
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }

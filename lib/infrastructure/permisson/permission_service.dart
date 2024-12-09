import 'package:map_tutorial_template/domain/permission/i_permission_service.dart';
import 'package:map_tutorial_template/domain/permission/location_permission_status.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PermissionService implements IPermissionService {
  
  @override
  Future<bool> isLocationPermissionGranted() async {
    // Use geolocator to check if location permission is granted
    final status = await Geolocator.checkPermission();
    var isGranted = status == LocationPermission.always || status == LocationPermission.whileInUse;
    return isGranted;
  }

  @override
  Future<bool> isLocationServicesEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Stream<bool> get locationServicesStatusStream {
    return Geolocator.getServiceStatusStream()
        .map((status) => status == ServiceStatus.enabled);
  }

  @override
  Future<LocationPermissionStatus> requestLocationPermission() async {
    final status = await Geolocator.requestPermission();
    var isGranted = status == LocationPermission.always || status == LocationPermission.whileInUse;
    if (isGranted) return LocationPermissionStatus.granted;
    if (status == LocationPermission.denied) return LocationPermissionStatus.denied;
    if (status == LocationPermission.deniedForever) return LocationPermissionStatus.permanentlyDenied;
    return LocationPermissionStatus.denied;
  }

  @override
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  @override
  Future<void> openApplicationSettings() async {
    // Use geolocator to open application settings
    await Geolocator.openAppSettings();
  }
}
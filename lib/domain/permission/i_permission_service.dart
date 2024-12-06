import 'package:map_tutorial_template/domain/permission/location_permission_status.dart';

abstract class IPermissionService {
  /// Checks if location permission is granted by the user
  Future<bool> isLocationPermissionGranted();

  /// Checks if device location services are enabled
  Future<bool> isLocationServicesEnabled();

  /// A stream that tracks location services status
  Stream<bool> get locationServicesStatusStream;

  /// Requests location permission from the user
  Future<LocationPermissionStatus> requestLocationPermission();

  /// Opens the device settings to enable location services
  Future<void> openLocationSettings();

  /// Opens the app settings to enable location services
  Future<void> openApplicationSettings();
}

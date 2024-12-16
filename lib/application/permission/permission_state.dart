part of 'permission_cubit.dart';

@freezed
class PermissionState with _$PermissionState {
  const PermissionState._();

  const factory PermissionState({
    @Default(false) bool isLocationServiceEnabled,
    @Default(false) bool isLocationPermissionGranted,
  }) = _PermissionState;

  factory PermissionState.initial() {
    return const PermissionState(
      isLocationServiceEnabled: false,
      isLocationPermissionGranted: false,
    );
  }

  bool get isLocationPermissionGrantedAndServicesEnabled =>
      isLocationPermissionGranted && isLocationServiceEnabled;
}

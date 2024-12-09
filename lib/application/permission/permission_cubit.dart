import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:map_tutorial_template/domain/permission/i_permission_service.dart';
import 'package:map_tutorial_template/domain/permission/location_permission_status.dart';

part 'permission_state.dart';
part 'permission_cubit.freezed.dart';
@lazySingleton
class PermissionCubit extends Cubit<PermissionState> {
  final IPermissionService _permissionService;
  PermissionCubit(this._permissionService) : super(PermissionState.initial());
  StreamSubscription<bool>? _locationServicesStatusSubscription;


  Future<void> initialize() async {
    final isLocationServiceEnabled = await _permissionService.isLocationServicesEnabled();
    final isLocationPermissionGranted = await _permissionService.isLocationPermissionGranted();

    _locationServicesStatusSubscription = _permissionService.locationServicesStatusStream.listen((isEnabled) {
      emit(state.copyWith(isLocationServiceEnabled: isEnabled));
    });

    emit(state.copyWith(isLocationServiceEnabled: isLocationServiceEnabled, isLocationPermissionGranted: isLocationPermissionGranted),);
  }

  Future<void> requestLocationPermission() async {
    final status = await _permissionService.requestLocationPermission();
    emit(state.copyWith(isLocationPermissionGranted: status == LocationPermissionStatus.granted));
  }

  Future<void> openLocationSettings() async {
    await _permissionService.openLocationSettings();
  }

  Future<void> openApplicationSettings() async {
    await _permissionService.openApplicationSettings();
  }

  @override
  Future<void> close() {
    _locationServicesStatusSubscription?.cancel();
    return super.close();
  }


}

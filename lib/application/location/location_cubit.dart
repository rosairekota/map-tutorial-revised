import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:map_tutorial_template/application/permission/permission_cubit.dart';
import 'package:map_tutorial_template/domain/location/i_location_service.dart';
import 'package:map_tutorial_template/domain/location/location_model.dart';
import 'package:map_tutorial_template/injection.dart';

part 'location_state.dart';
part 'location_cubit.freezed.dart';

@lazySingleton
class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationState.initial());

  final ILocationService _locationService = getIt<ILocationService>();
  final PermissionCubit _permissionCubit = getIt<PermissionCubit>();
  StreamSubscription<LocationModel>? _locationSubscription;
  StreamSubscription<PermissionState>? _permissionSubscription;

  void initialize() {
    var isLocationAccessible =
        _permissionCubit.state.isLocationPermissionGranted &&
            _permissionCubit.state.isLocationServiceEnabled;

    if (isLocationAccessible) {
      _openLocationSubscription();
    }
    _permissionSubscription?.cancel();
    _permissionSubscription = _permissionCubit.stream.listen((permissionState) {
      if (permissionState.isLocationPermissionGranted &&
          permissionState.isLocationServiceEnabled) {
        _openLocationSubscription();
      } else {
        _locationSubscription?.cancel();
      }
    });
  }

  void _openLocationSubscription() {
    _locationSubscription?.cancel();
    _locationSubscription = _locationService.locationStream.listen((location) {
      emit(state.copyWith(userLocation: location));
    });
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    _permissionSubscription?.cancel();
    return super.close();
  }
}

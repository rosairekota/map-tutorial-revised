part of 'location_cubit.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    LocationModel? userLocation,
  }) = _LocationState;

  factory LocationState.initial() {
    return const LocationState(
      userLocation: null,
    );
  }
}

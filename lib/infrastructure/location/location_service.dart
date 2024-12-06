
import 'package:geolocator/geolocator.dart';
import 'package:map_tutorial_template/domain/location/i_location_service.dart';
import 'package:map_tutorial_template/domain/location/location_model.dart';

class LocationService implements ILocationService {
  @override
  Stream<LocationModel> get locationStream => Geolocator.getPositionStream().map((position) => LocationModel(latitude: position.latitude, longitude: position.longitude));
}

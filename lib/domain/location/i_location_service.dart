import 'package:map_tutorial_template/domain/location/location_model.dart';

abstract class ILocationService {
  /// A stream that emits the current location
  Stream<LocationModel> get locationStream;
}


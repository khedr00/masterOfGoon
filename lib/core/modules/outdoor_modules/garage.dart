import 'package:untitled1/core/modules/outdoor_modules/out_door_place.dart';

class Garage extends OutDoorPlace {
  Garage({
    required super.description,
    required super.sqft,
    required super.photos,
    required this.carCapacity,
    required this.automaticDoor,
  });

  final int carCapacity;
  final bool automaticDoor;
}

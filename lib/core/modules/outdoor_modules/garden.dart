import 'package:untitled1/core/modules/outdoor_modules/out_door_place.dart';

class Garden extends OutDoorPlace {
  Garden({
    required super.description,
    required super.sqft,
    required super.photos,
    required this.hasTrees,
    required this.hasGrass,
    required this.automaticIrrigation,
  });

  final bool hasTrees;
  final bool hasGrass;
  final bool automaticIrrigation;
}

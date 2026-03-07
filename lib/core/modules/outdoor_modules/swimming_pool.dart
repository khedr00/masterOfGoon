import 'package:untitled1/core/modules/outdoor_modules/out_door_place.dart';

class SwimmingPool extends OutDoorPlace {
  SwimmingPool({
    required super.description,
    required super.sqft,
    required super.photos,
    required this.depth,
    required this.heated,
    required this.covered,
  });

  final double depth;
  final bool heated;
  final bool covered;
}

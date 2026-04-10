import 'package:untitled1/core/modules/outdoor_modules/out_door_place.dart';

class Balcony extends OutDoorPlace {
  Balcony({
    required super.description,
    required super.sqft,
    required super.photos,
    required this.roomId,
  });

  final int roomId;
}

import 'package:untitled1/core/models/out_door_place.dart';
import 'package:untitled1/core/models/property-modules/propetry.dart';

class House extends Property {
  House({
    required super.outDoorPhotos,
    required super.address,
    required super.constructionYear,
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.nameCode,
    required super.originalOwner,
    required super.primaryPhoto,
    required super.simpleDescription,
    required super.sqft,
    required this.numberOfFloors,
    required super.numberOfRooms,
    required super.fullDescription,
    required super.outSidePainting,
    required super.busStop,
    required super.hospital,
    required super.markets,
    required super.pharmacy,
    required super.publicPark,
    required super.school,
    required super.university,
    required this.garden,
    required this.pool,
    required this.parking,
    required super.furnitureState,
    required super.falseCeilings,
    required super.avaliableInternet,
  });
  final int numberOfFloors;
  final OutDoorPlace garden;
  final OutDoorPlace pool;
  final OutDoorPlace parking;
}

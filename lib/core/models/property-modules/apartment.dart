import 'package:untitled1/core/models/property-modules/propetry.dart';

class Apartment extends Property {
  Apartment({
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
    required super.furnitureState,
    required super.falseCeilings,
    required this.floorNumber,
    required this.elevator,
    required this.buildingParking,
    required super.avaliableInternet,
  });
  final int floorNumber;
  final bool elevator;
  final bool buildingParking;
}

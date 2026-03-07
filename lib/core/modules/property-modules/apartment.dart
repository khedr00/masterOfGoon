import 'package:untitled1/core/modules/property-modules/propetry.dart';

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
    required super.outsidePainting,
    required super.furnitureState,
    required this.floorNumber,
    required this.elevator,
    required this.buildingParking,
    required super.avaliableInternet,
    required super.rooms,
    required super.nearbyPlaces,
    required super.catagory,
  });
  final int floorNumber;
  final bool elevator;
  final bool buildingParking;
}

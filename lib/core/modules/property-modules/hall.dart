import 'package:untitled1/core/modules/property-modules/propetry.dart';

class Hall extends Property {
  Hall({
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
    required this.floorNumber,
    required super.numberOfRooms,
    required super.fullDescription,
    required super.outsidePainting,
    required super.furnitureState,
    required super.avaliableInternet,
    required super.rooms,
    required super.nearbyPlaces,
    required super.catagory,
  });
  final int floorNumber;
}

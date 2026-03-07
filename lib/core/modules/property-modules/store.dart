import 'package:untitled1/core/modules/outdoor_modules/out_door_place.dart';
import 'package:untitled1/core/modules/property-modules/propetry.dart';

class Store extends Property {
  Store({
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
    required this.interface,
    required super.rooms,
    required super.nearbyPlaces,
    required super.catagory,
  });
  final int floorNumber;
  final OutDoorPlace interface;
}

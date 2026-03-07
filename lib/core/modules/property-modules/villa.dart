import 'package:untitled1/core/modules/outdoor_modules/out_door_place.dart';
import 'package:untitled1/core/modules/property-modules/propetry.dart';

class Villa extends Property {
  Villa({
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
    required super.outsidePainting,
    required this.outDoorPlaces,
    required super.furnitureState,
    required super.avaliableInternet,
    required super.rooms,
    required super.nearbyPlaces,
    required super.catagory,
  });
  final int numberOfFloors;
  final List<OutDoorPlace> outDoorPlaces;
}

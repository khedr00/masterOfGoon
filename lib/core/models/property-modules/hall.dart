import 'package:untitled1/core/models/out_door_place.dart';
import 'package:untitled1/core/models/property-modules/propetry.dart';

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
    required super.avaliableInternet,
    required this.interface,
  });
  final int floorNumber;
  final OutDoorPlace interface;
}

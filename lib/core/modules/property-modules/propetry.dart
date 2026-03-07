import 'package:untitled1/core/modules/photo.dart';
import 'package:untitled1/core/modules/property-modules/nearby_place.dart';
import 'package:untitled1/core/modules/room_modules/room.dart';
import 'package:untitled1/core/modules/transaction_modules/transaction_catagory.dart';

enum Furniture { none, semi, full }

class Property {
  final int id;
  final String nameCode;
  final TransactionCatagory catagory;
  final double sqft;
  final String address;
  final double longitude;
  final double latitude;
  final String simpleDescription;
  final String fullDescription;
  final Photo primaryPhoto;
  final List<Photo> outDoorPhotos;
  final String originalOwner;
  final int constructionYear;
  final int numberOfRooms;
  final String outsidePainting;
  final Furniture furnitureState;
  final List<Room> rooms;
  final List<NearbyPlace> nearbyPlaces;
  final bool avaliableInternet;

  Property({
    required this.outsidePainting,
    required this.outDoorPhotos,
    required this.fullDescription,
    required this.id,
    required this.nameCode,
    required this.sqft,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.simpleDescription,
    required this.primaryPhoto,
    required this.originalOwner,
    required this.constructionYear,
    required this.numberOfRooms,
    required this.furnitureState,
    required this.avaliableInternet,
    required this.rooms,
    required this.nearbyPlaces,
    required this.catagory,
  });
}

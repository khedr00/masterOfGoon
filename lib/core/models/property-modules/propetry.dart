import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:untitled1/core/models/photo.dart';

enum Furniture { none, semi, full }

class Property {
  final int id;
  final String nameCode;
  final Double sqft;
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
  final String outSidePainting;
  final Furniture furnitureState;
  final bool school;
  final bool hospital;
  final bool university;
  final bool pharmacy;
  final bool markets;
  final bool busStop;
  final bool publicPark;
  final bool falseCeilings;
  final bool avaliableInternet;

  Property({
    required this.outSidePainting,
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
    required this.busStop,
    required this.hospital,
    required this.markets,
    required this.pharmacy,
    required this.publicPark,
    required this.school,
    required this.university,
    required this.furnitureState,
    required this.falseCeilings,
    required this.avaliableInternet,
  });

  // factory Property.fromJson(Map<String, dynamic> json) {
  //   return Property(
  //     id: json['id'],
  //     nameCode: json['nameCode'],
  //     sqft: json['sqft'],
  //     address: json['address'],
  //     longitude: (json['longitude'] as num).toDouble(),
  //     latitude: (json['latitude'] as num).toDouble(),
  //     simpleDescription: json['simpleDescription'],
  //     primaryPhoto: json['primaryPhoto'],
  //     originalOwner: json['originalOwner'],
  //     galleryPhotoUrls: List<String>.from(json['galleryPhotoUrls']),
  //     constructionYear: json['propertyAge'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'nameCode': nameCode,
  //     'sqft': sqft,
  //     'address': address,
  //     'longitude': longitude,
  //     'latitude': latitude,
  //     'simpleDescription': simpleDescription,
  //     'primaryPhoto': primaryPhoto,
  //     'galleryPhotoUrls': galleryPhotoUrls,
  //     'originalOwner': originalOwner,
  //     'propertyAge': constructionYear,
  //   };
  // }
}

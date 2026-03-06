import 'package:untitled1/core/models/property-modules/propetry.dart';

class Villa extends Property {
  Villa({
    required super.address,
    required super.constructionYear,
    required super.galleryPhotoUrls,
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.nameCode,
    required super.originalClient,
    required super.primaryPhoto,
    required super.simpleDescription,
    required super.sqft,
    required this.numberOfFloors,
    required this.numberOfRooms,
  });
  final int numberOfFloors;
  final int numberOfRooms;
}

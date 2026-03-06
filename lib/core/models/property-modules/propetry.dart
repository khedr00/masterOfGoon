import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

class Property {
  final int id;
  final String nameCode;
  final Double sqft;
  final String address;
  final double longitude;
  final double latitude;
  final String simpleDescription;
  final String primaryPhoto;
  final List<String> galleryPhotoUrls;
  final String originalClient;
  final int constructionYear;

  Property({
    required this.id,
    required this.nameCode,
    required this.sqft,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.simpleDescription,
    required this.primaryPhoto,
    required this.galleryPhotoUrls,
    required this.originalClient,
    required this.constructionYear,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      nameCode: json['nameCode'],
      sqft: json['sqft'],
      address: json['address'],
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      simpleDescription: json['simpleDescription'],
      primaryPhoto: json['primaryPhoto'],
      originalClient: json['originalClient'],
      galleryPhotoUrls: List<String>.from(json['galleryPhotoUrls']),
      constructionYear: json['propertyAge'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameCode': nameCode,
      'sqft': sqft,
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
      'simpleDescription': simpleDescription,
      'primaryPhoto': primaryPhoto,
      'galleryPhotoUrls': galleryPhotoUrls,
      'originalClient': originalClient,
      'propertyAge': constructionYear,
    };
  }
}

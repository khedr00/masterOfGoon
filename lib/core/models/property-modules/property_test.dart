class PropertyTest {
  final int id;
  final String nameCode;
  final String propertyType;
  final bool isForSale;
  final String simpleDescription;
  final String fullDescription;
  final String location;
  final String address;
  final double minimumSellPrice;
  final double maximumBuyPrice;
  final int? rentalPeriod;
  final double listedPrice;
  final double rating;
  final int numberOfRooms;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final double sqft;
  final bool hasParking;
  final String? outdoorArea;
  final bool isFurnished;
  final bool hasCentralHeating;
  final bool hasPool;
  final double longitude;
  final double latitude;
  final String primaryPhoto;
  final List<String> galleryPhotoUrls;
  final bool school;
  final bool hospital;
  final bool university;
  final bool pharmacy;
  final bool markets;
  final bool busStop;
  final bool publicPark;
  final int constructionYear;
  final bool isAvilable;

  PropertyTest({
    required this.isAvilable,
    required this.id,
    required this.nameCode,
    required this.propertyType,
    required this.isForSale,
    required this.simpleDescription,
    required this.fullDescription,
    required this.location,
    required this.address,
    required this.minimumSellPrice,
    required this.maximumBuyPrice,
    this.rentalPeriod,
    required this.listedPrice,
    required this.rating,
    required this.numberOfRooms,
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.sqft,
    required this.hasParking,
    this.outdoorArea,
    required this.isFurnished,
    required this.hasCentralHeating,
    required this.hasPool,
    required this.longitude,
    required this.latitude,
    required this.primaryPhoto,
    required this.galleryPhotoUrls,
    required this.school,
    required this.hospital,
    required this.university,
    required this.pharmacy,
    required this.markets,
    required this.busStop,
    required this.publicPark,
    required this.constructionYear,
  });

  factory PropertyTest.fromJson(Map<String, dynamic> json) {
    return PropertyTest(
      id: json['id'],
      nameCode: json['nameCode'],
      propertyType: json['propertyType'],
      isForSale: json['isForSale'],
      simpleDescription: json['simpleDescription'],
      fullDescription: json['fullDescription'],
      location: json['location'],
      address: json['address'],
      minimumSellPrice: (json['minimumSellPrice'] as num).toDouble(),
      maximumBuyPrice: (json['maximumBuyPrice'] as num).toDouble(),
      rentalPeriod: json['rentalPeriod'],
      listedPrice: (json['listedPrice'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      numberOfRooms: json['numberOfRooms'],
      numberOfBedrooms: json['numberOfBedrooms'],
      numberOfBathrooms: json['numberOfBathrooms'],
      sqft: (json['sqft'] as num).toDouble(),
      hasParking: json['hasParking'],
      outdoorArea: json['outdoorArea'],
      isFurnished: json['isFurnished'],
      hasCentralHeating: json['hasCentralHeating'],
      hasPool: json['hasPool'],
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      primaryPhoto: json['primaryPhoto'],
      galleryPhotoUrls: List<String>.from(json['galleryPhotoUrls']),
      school: json['school'],
      hospital: json['hospital'],
      university: json['university'],
      pharmacy: json['pharmacy'],
      markets: json['markets'],
      busStop: json['busStop'],
      publicPark: json['publicPark'],
      constructionYear: json['propertyAge'],
      isAvilable: json['isAvilable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameCode': nameCode,
      'propertyType': propertyType,
      'isForSale': isForSale,
      'simpleDescription': simpleDescription,
      'fullDescription': fullDescription,
      'location': location,
      'address': address,
      'minimumSellPrice': minimumSellPrice,
      'maximumBuyPrice': maximumBuyPrice,
      'rentalPeriod': rentalPeriod,
      'listedPrice': listedPrice,
      'rating': rating,
      'numberOfRooms': numberOfRooms,
      'numberOfBedrooms': numberOfBedrooms,
      'numberOfBathrooms': numberOfBathrooms,
      'sqft': sqft,
      'hasParking': hasParking,
      'outdoorArea': outdoorArea,
      'isFurnished': isFurnished,
      'hasCentralHeating': hasCentralHeating,
      'hasPool': hasPool,
      'longitude': longitude,
      'latitude': latitude,
      'primaryPhoto': primaryPhoto,
      'galleryPhotoUrls': galleryPhotoUrls,
      'school': school,
      'hospital': hospital,
      'university': university,
      'pharmacy': pharmacy,
      'markets': markets,
      'busStop': busStop,
      'publicPark': publicPark,
      'propertyAge': constructionYear,
      'isAvalible': isAvilable,
    };
  }
}

class PropertyCardModel {
  final String id;
  final String referenceCode;
  final String type;
  final String listingType;
  final String simpleDescription;
  final String city;
  final String listedPrice;
  final String sqft;
  final int numOfRooms;
  final String primaryPhoto;

  const PropertyCardModel({
    required this.id,
    required this.referenceCode,
    required this.type,
    required this.listingType,
    required this.simpleDescription,
    required this.city,
    required this.listedPrice,
    required this.sqft,
    required this.numOfRooms,
    required this.primaryPhoto,
  });

  factory PropertyCardModel.fromJson(Map<String, dynamic> json) {
    return PropertyCardModel(
      id: json['id'] ?? '',
      referenceCode: json['referenceCode'] ?? '',
      type: json['type'] ?? '',
      listingType: json['listingType'] ?? '',
      simpleDescription: json['simpleDescription'] ?? '',
      city: json['city'] ?? '',
      listedPrice: json['listedPrice']?.toString() ?? '',
      sqft: json['sqft']?.toString() ?? '',
      numOfRooms: json['numOfRooms'] ?? 0,
      primaryPhoto: json['primaryPhoto'] ?? '',
    );
  }
}

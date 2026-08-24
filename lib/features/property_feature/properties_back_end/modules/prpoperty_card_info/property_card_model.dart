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
      numOfRooms: _roomCount(json),
      primaryPhoto: json['primaryPhoto'] ?? '',
    );
  }
}

int _roomCount(Map<String, dynamic> json) {
  final values = [
    json['numOfRooms'],
    json['numberOfRooms'],
    json['roomsCount'],
    json['roomCount'],
    json['numberOfRoom'],
    json['number_of_rooms'],
    json['rooms'],
  ];
  for (final value in values) {
    final count = _int(value);
    if (count > 0) return count;
  }
  final roomItems = json['roomItems'];
  return roomItems is List ? roomItems.length : 0;
}

int _int(Object? value) {
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString().trim() ?? '') ?? 0;
}

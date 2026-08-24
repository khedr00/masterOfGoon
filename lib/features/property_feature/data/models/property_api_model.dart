class PropertyApiModel {
  const PropertyApiModel({
    required this.id,
    required this.referenceCode,
    required this.type,
    required this.listingType,
    required this.simpleDescription,
    required this.fullDescription,
    required this.paintingDescription,
    required this.address,
    required this.city,
    required this.listedPrice,
    required this.sqft,
    required this.numOfRooms,
    required this.furnishing,
    required this.numOfFloors,
    required this.floorNumber,
    required this.elevator,
    required this.parking,
    required this.garageCars,
    required this.isAvailable,
    required this.primaryPhoto,
    required this.galleryPhoto,
    required this.nearbyPlaces,
    required this.roomItems,
    required this.outdoorItems,
    this.raw = const {},
  });

  final String id;
  final String referenceCode;
  final String type;
  final String listingType;
  final String simpleDescription;
  final String fullDescription;
  final String paintingDescription;
  final String address;
  final String city;
  final num listedPrice;
  final num sqft;
  final int numOfRooms;
  final String furnishing;
  final int numOfFloors;
  final int floorNumber;
  final bool elevator;
  final bool parking;
  final int? garageCars;
  final bool? isAvailable;
  final String primaryPhoto;
  final List<String> galleryPhoto;
  final List<NearbyPlaceApiModel> nearbyPlaces;
  final List<RoomItemApiModel> roomItems;
  final List<OutdoorItemApiModel> outdoorItems;
  final Map<String, dynamic> raw;

  factory PropertyApiModel.fromJson(Map<String, dynamic> json) {
    final roomItems = _maps(
      json['roomItems'],
    ).map(RoomItemApiModel.fromJson).toList();
    final outdoorItems = _maps(
      json['outdoorItems'],
    ).map(OutdoorItemApiModel.fromJson).toList();
    return PropertyApiModel(
      id: _string(json['id']),
      referenceCode: _string(json['referenceCode']),
      type: _string(json['type']),
      listingType: _string(json['listingType']),
      simpleDescription: _string(json['simpleDescription']),
      fullDescription: _string(json['fullDescription']),
      paintingDescription: _firstNonEmpty([
        json['paintingDescription'],
        json['paintDescription'],
        json['outsidePainting'],
        json['exteriorPainting'],
        json['exteriorFinishDescription'],
        json['exteriorFinish'],
      ]),
      address: _firstNonEmpty([
        json['address'],
        json['location'],
        json['city'],
      ]),
      city: _string(json['city']),
      listedPrice: _num(json['listedPrice']),
      sqft: _num(json['sqft']),
      numOfRooms: _roomCount(json, roomItems),
      furnishing: _enumLabel(_string(json['furnishing'])),
      numOfFloors: _int(json['numOfFloors']),
      floorNumber: _int(json['floorNumber']),
      elevator: json['elevator'] == true,
      parking: json['parking'] == true,
      garageCars: _garageCars(json, outdoorItems),
      isAvailable: _nullableBool(
        json['isAvailable'] ??
            json['available'] ??
            json['isAvaliable'] ??
            json['avaliable'],
      ),
      primaryPhoto: _string(json['primaryPhoto']),
      galleryPhoto: _strings(json['galleryPhoto']),
      nearbyPlaces: _nearbyPlaces(json['nearbyPlaces'] ?? json['nearByPlaces']),
      roomItems: roomItems,
      outdoorItems: outdoorItems,
      raw: Map<String, dynamic>.from(json),
    );
  }
}

class RoomItemApiModel {
  const RoomItemApiModel({
    required this.id,
    required this.type,
    required this.size,
    required this.description,
    required this.paintDescription,
    required this.hasBalcony,
    required this.bathroomWeight,
    required this.balconyData,
    required this.data,
    required this.photos,
  });
  final String id;
  final String type;
  final num size;
  final String description;
  final String paintDescription;
  final bool hasBalcony;
  final num bathroomWeight;
  final Map<String, dynamic> balconyData;
  final Map<String, dynamic> data;
  final List<String> photos;
  factory RoomItemApiModel.fromJson(Map<String, dynamic> json) =>
      RoomItemApiModel(
        id: _string(json['id']),
        type: _enumLabel(_string(json['type'])),
        size: _num(json['size']),
        description: _string(json['description']),
        paintDescription: _string(json['paintDescription']),
        hasBalcony: json['hasBalcony'] == true,
        bathroomWeight: _num(json['bathroomWeight']),
        balconyData: _map(json['balconyData']),
        data: _map(json['data']),
        photos: _strings(json['photos']),
      );
  String get summary => [
    type,
    size == 0 ? '' : '$size M',
    description,
    paintDescription,
    hasBalcony ? 'Balcony' : '',
  ].where((value) => value.isNotEmpty).join(' • ');
}

class OutdoorItemApiModel {
  const OutdoorItemApiModel({
    required this.id,
    required this.type,
    required this.description,
    required this.data,
    required this.photos,
  });
  final String id;
  final String type;
  final String description;
  final Map<String, dynamic> data;
  final List<String> photos;
  factory OutdoorItemApiModel.fromJson(Map<String, dynamic> json) {
    final data = _map(json['data']);
    return OutdoorItemApiModel(
      id: _string(json['id']),
      type: _enumLabel(_string(json['type'])),
      description: _firstNonEmpty([
        json['description'],
        data['description'],
        data['desc'],
        data['spec'],
      ]),
      data: data,
      photos: _strings(json['photos']),
    );
  }
  String get summary =>
      [type, description].where((value) => value.isNotEmpty).join(' • ');
}

class NearbyPlaceApiModel {
  const NearbyPlaceApiModel({required this.name, required this.distance});
  final String name;
  final num distance;
  factory NearbyPlaceApiModel.fromJson(Map<String, dynamic> json) =>
      NearbyPlaceApiModel(
        name: _firstNonEmpty([
          json['name'],
          json['type'],
          json['place'],
          json['nearbyPlace'],
          json['category'],
        ]),
        distance: _num(
          json['distance'] ??
              json['destance'] ??
              json['distance_km'] ??
              json['distanceKm'] ??
              json['distance_m'] ??
              json['distanceM'],
        ),
      );
}

String _string(Object? value) => value?.toString().trim() ?? '';
num _num(Object? value) =>
    value is num ? value : num.tryParse(_string(value)) ?? 0;
int _int(Object? value) => _num(value).toInt();
int _roomCount(Map<String, dynamic> json, List<RoomItemApiModel> roomItems) {
  final value = _firstPositiveInt([
    json['numOfRooms'],
    json['numberOfRooms'],
    json['roomsCount'],
    json['roomCount'],
    json['numberOfRoom'],
    json['number_of_rooms'],
    json['rooms'],
  ]);
  if (value > 0) return value;
  return roomItems.length;
}

bool? _nullableBool(Object? value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  final normalized = _string(value).toLowerCase();
  if (normalized.isEmpty) return null;
  if (['true', 'yes', 'available', '1'].contains(normalized)) return true;
  if ([
    'false',
    'no',
    'unavailable',
    'not available',
    '0',
  ].contains(normalized)) {
    return false;
  }
  return null;
}

int _firstPositiveInt(Iterable<Object?> values) {
  for (final value in values) {
    final number = _int(value);
    if (number > 0) return number;
  }
  return 0;
}

int _garageCars(
  Map<String, dynamic> json,
  List<OutdoorItemApiModel> outdoorItems,
) {
  final garageOutdoor = outdoorItems.where(
    (item) => item.type.toLowerCase().contains('garage'),
  );
  final garageOutdoorCapacity = _firstPositiveInt(
    garageOutdoor.expand(
      (item) => [
        item.data['carCapacity'],
        item.data['cars'],
        item.data['carCount'],
        item.data['garageCars'],
        item.data['parkingSpaces'],
        item.data['parkingSpots'],
        item.data['capacity'],
        item.data['spec'],
        item.data['desc'],
      ],
    ),
  );
  if (garageOutdoorCapacity > 0) return garageOutdoorCapacity;

  final propertyCapacity = _firstPositiveInt([
    json['garageCars'],
    json['garageCarsCount'],
    json['numberOfGarageCars'],
    json['numOfGarageCars'],
    json['carCapacity'],
    json['garageCapacity'],
    json['parkingSpaces'],
    json['parkingSpots'],
    json['parkingCapacity'],
    json['garageCarCount'],
    json['carsNumber'],
    json['numOfCars'],
    json['internalGarageCars'],
  ]);
  if (propertyCapacity > 0) return propertyCapacity;

  return json['parking'] == true ? 1 : 0;
}

List<NearbyPlaceApiModel> _nearbyPlaces(Object? value) {
  final places = <NearbyPlaceApiModel>[];
  for (final map in _nearbyPlaceMaps(value)) {
    final place = NearbyPlaceApiModel.fromJson(map);
    if (place.name.isNotEmpty) places.add(place);
  }
  return places;
}

List<Map<String, dynamic>> _nearbyPlaceMaps(Object? value) {
  if (value is List) {
    return _nearbyPlaceList(value);
  }
  if (value is! Map) return const [];

  final map = Map<String, dynamic>.from(value);
  if (_looksLikeNearbyPlace(map)) return [map];

  final places = <Map<String, dynamic>>[];
  map.forEach((key, entries) {
    final category = _enumLabel(_string(key));
    if (entries is List) {
      for (final entry in entries) {
        places.addAll(_nearbyPlaceEntry(entry, category));
      }
    } else {
      places.addAll(_nearbyPlaceEntry(entries, category));
    }
  });
  return places;
}

List<Map<String, dynamic>> _nearbyPlaceList(List<Object?> value) {
  final places = <Map<String, dynamic>>[];
  for (final entry in value) {
    places.addAll(_nearbyPlaceEntry(entry, ''));
  }
  return places;
}

List<Map<String, dynamic>> _nearbyPlaceEntry(Object? value, String category) {
  if (value is Map) {
    final map = Map<String, dynamic>.from(value);
    if (category.isNotEmpty) map.putIfAbsent('category', () => category);
    return [map];
  }

  final label = _string(value);
  if (label.isEmpty && category.isEmpty) return const [];
  return [
    {
      'name': label.isEmpty ? category : label,
      if (category.isNotEmpty) 'category': category,
    },
  ];
}

bool _looksLikeNearbyPlace(Map<String, dynamic> value) =>
    value.containsKey('name') ||
    value.containsKey('type') ||
    value.containsKey('place') ||
    value.containsKey('nearbyPlace') ||
    value.containsKey('category') ||
    value.containsKey('distance') ||
    value.containsKey('destance') ||
    value.containsKey('distance_km') ||
    value.containsKey('distanceKm') ||
    value.containsKey('distance_m') ||
    value.containsKey('distanceM');

Map<String, dynamic> _map(Object? value) =>
    value is Map ? Map<String, dynamic>.from(value) : const {};
List<Map<String, dynamic>> _maps(Object? value) => value is List
    ? value
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList()
    : const [];
List<String> _strings(Object? value) => value is List
    ? value.map(_string).where((item) => item.isNotEmpty).toList()
    : const [];
String _firstNonEmpty(List<Object?> values) => values
    .map(_string)
    .firstWhere((value) => value.isNotEmpty, orElse: () => '');
String _enumLabel(String value) => value
    .split('_')
    .where((part) => part.isNotEmpty)
    .map((part) => '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}')
    .join(' ');

import 'package:untitled1/core/modules/property-modules/nearby_place.dart';

class PropertyInfoWithPrimaryImages {
  PropertyInfoWithPrimaryImages({
    required this.nameCode,
    required this.simplePropertyDescription,
    required this.fullPropertyDescription,
    required this.isAvaliable,
    required this.address,
    required this.leastSellPrice,
    required this.fakePrice,
    required this.sqft,
    required this.primaryPhoto,
    required this.otherPhotos,
    required this.numberOfRooms,
    required this.outsidePainting,
    required this.furnitureState,
    required this.nearByPlaces,
    required this.avaliableInternet,
  });
  final String nameCode;
  final String simplePropertyDescription;
  final String fullPropertyDescription;
  final bool isAvaliable;
  final String address;
  final int leastSellPrice;
  final int fakePrice;
  final int sqft;
  final String primaryPhoto;
  final List<String> otherPhotos;
  final int numberOfRooms;
  final String outsidePainting;
  final String furnitureState;
  final List<NearbyPlace> nearByPlaces;
  final bool avaliableInternet;
}

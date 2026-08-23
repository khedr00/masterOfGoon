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
    required this.propertyType,
  });
  final String nameCode;
  final String propertyType;
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
  String getpropertyIcon(String propertyType) {
    switch (propertyType) {
      case ('house'):
        return 'assets/images/house_kind.png';
      case ('villa'):
        return 'assets/images/Mansion.png';
      case ('store'):
        return 'assets/images/Shop-kind.png';
      case ('hall'):
        return 'assets/images/City Hall.png';
      case ('aprmnt'):
        return 'assets/images/apartment-kind.png';
      default:
        return 'assets/images/house_kind.png';
    }
  }
}

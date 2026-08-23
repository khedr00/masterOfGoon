import 'package:untitled1/features/property_feature/properties_back_end/modules/property_info_with_primary_images/property_info_with_primary_images.dart';

class StoreInfoWithPrimaryImages extends PropertyInfoWithPrimaryImages {
  StoreInfoWithPrimaryImages({
    required super.nameCode,
    required super.simplePropertyDescription,
    required super.fullPropertyDescription,
    required super.isAvaliable,
    required super.address,
    required super.leastSellPrice,
    required super.fakePrice,
    required super.sqft,
    required super.primaryPhoto,
    required super.otherPhotos,
    required super.numberOfRooms,
    required super.outsidePainting,
    required super.furnitureState,
    required super.nearByPlaces,
    required super.avaliableInternet,
    required this.floorNumber,
    required this.storeFront,
    required super.propertyType,
  });
  final int floorNumber;
  final String storeFront;
}

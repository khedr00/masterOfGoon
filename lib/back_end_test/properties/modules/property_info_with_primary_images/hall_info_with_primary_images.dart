import 'package:untitled1/back_end_test/properties/modules/property_info_with_primary_images/property_info_with_primary_images.dart';

class HallInfoWithPrimaryImages extends PropertyInfoWithPrimaryImages {
  HallInfoWithPrimaryImages({
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
    required super.propertyType,
  });
  final int floorNumber;
}

import 'package:untitled1/back_end_test/properties/modules/property_card_module_info.dart';

class HouseCardModuleInfo extends PropertyCardModuleInfo {
  HouseCardModuleInfo({
    required super.photoUrl,
    required super.propertyType,
    required super.nameCode,
    required super.numberOfRooms,
    required super.sqft,
    required super.leastSellPrice,
    required super.simplePropertyDescription,
    required super.address,
    required this.numberOfFloors,
    required super.avaliableInternet,
  });
  final int numberOfFloors;
}

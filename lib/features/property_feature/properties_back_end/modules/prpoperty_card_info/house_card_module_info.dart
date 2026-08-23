import 'package:untitled1/features/property_feature/properties_back_end/modules/prpoperty_card_info/property_card_module_info.dart';

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
    required super.isAvalable,
    required super.id,
  });
  final int numberOfFloors;
}

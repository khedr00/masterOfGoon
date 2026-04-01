import 'package:untitled1/back_end_test/properties/modules/property_card_module_info.dart';

class AppartmentCardModuleInfo extends PropertyCardModuleInfo {
  AppartmentCardModuleInfo({
    required super.photoUrl,
    required super.propertyType,
    required super.nameCode,
    required super.numberOfRooms,
    required super.sqft,
    required super.leastSellPrice,
    required super.simplePropertyDescription,
    required super.address,
    required this.elevator,
    required super.avaliableInternet,
  });
  final bool elevator;
}

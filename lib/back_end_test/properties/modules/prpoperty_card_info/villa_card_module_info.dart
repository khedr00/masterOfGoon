import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/property_card_module_info.dart';

class VillaCardModuleInfo extends PropertyCardModuleInfo {
  VillaCardModuleInfo({
    required super.photoUrl,
    required super.propertyType,
    required super.nameCode,
    required super.numberOfRooms,
    required super.sqft,
    required super.leastSellPrice,
    required super.simplePropertyDescription,
    required super.address,
    required this.garden,
    required super.avaliableInternet,
    required super.isAvalable,
    required super.id,
  });
  final bool garden;
}

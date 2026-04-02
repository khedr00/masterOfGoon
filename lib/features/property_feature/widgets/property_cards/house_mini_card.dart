import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/house_card_module_info.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/property_mini_card.dart';

class HouseMiniCard extends StatelessWidget {
  const HouseMiniCard({super.key, required this.houseCardModuleInfo});
  final HouseCardModuleInfo houseCardModuleInfo;

  @override
  Widget build(BuildContext context) {
    return PropertyMiniCard(
      propertyType: 'house',
      propertyTypeIcon: 'assets/images/house_kind.png',
      changingDataText: houseCardModuleInfo.numberOfFloors.toString(),
      changingDataTextIcon: 'assets/images/Stairs Up.png',
      propertyCardModuleInfo: houseCardModuleInfo,
    );
  }
}

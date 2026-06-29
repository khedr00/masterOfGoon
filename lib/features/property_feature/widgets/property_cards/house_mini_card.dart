import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/property_card_model.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/property_mini_card.dart';

class HouseMiniCard extends StatelessWidget {
  const HouseMiniCard({super.key, required this.houseCardModuleInfo});
  final PropertyCardModel houseCardModuleInfo;

  @override
  Widget build(BuildContext context) {
    return PropertyMiniCard(
      propertyType: 'house',
      propertyTypeIcon: 'assets/images/house_kind.png',
      changingDataText:
          //  houseCardModuleInfo.numberOfFloors.toString(),
          '2',
      changingDataTextIcon: 'assets/images/Stairs Up.png',
      propertyCardModuleInfo: houseCardModuleInfo,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/hall_card_module_info.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/property_mini_card.dart';

class HallMiniCard extends StatelessWidget {
  const HallMiniCard({super.key, required this.hallCardModuleInfo});
  final HallCardModuleInfo hallCardModuleInfo;

  @override
  Widget build(BuildContext context) {
    return PropertyMiniCard(
      propertyType: 'hall',
      propertyTypeIcon: 'assets/images/City Hall.png',
      changingDataText: hallCardModuleInfo.furnished,
      changingDataTextIcon: 'assets/images/Closet.png',
      propertyCardModuleInfo: hallCardModuleInfo,
    );
  }
}

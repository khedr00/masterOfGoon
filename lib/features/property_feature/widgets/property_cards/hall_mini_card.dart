import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/property_card_model.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/property_mini_card.dart';

class HallMiniCard extends StatelessWidget {
  const HallMiniCard({super.key, required this.hallCardModuleInfo});
  final PropertyCardModel hallCardModuleInfo;

  @override
  Widget build(BuildContext context) {
    return PropertyMiniCard(
      propertyType: 'hall',
      propertyTypeIcon: 'assets/images/City Hall.png',
      changingDataText:
          //  hallCardModuleInfo.furnished,
          'furnished',
      changingDataTextIcon: 'assets/images/Closet.png',
      propertyCardModuleInfo: hallCardModuleInfo,
    );
  }
}

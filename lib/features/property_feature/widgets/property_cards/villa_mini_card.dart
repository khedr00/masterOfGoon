import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/property_card_model.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/property_mini_card.dart';

class VillaMiniCard extends StatelessWidget {
  const VillaMiniCard({super.key, required this.villaCardModuleInfo});
  final PropertyCardModel villaCardModuleInfo;

  @override
  Widget build(BuildContext context) {
    return PropertyMiniCard(
      propertyType: 'villa',
      propertyTypeIcon: 'assets/images/Mansion.png',
      changingDataText:
          //  villaCardModuleInfo.garden ? 'garden' : 'no gardens',
          'garden',
      changingDataTextIcon: 'assets/images/Garden.png',
      propertyCardModuleInfo: villaCardModuleInfo,
    );
  }
}

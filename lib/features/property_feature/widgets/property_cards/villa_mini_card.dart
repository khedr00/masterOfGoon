import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/villa_card_module_info.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/property_mini_card.dart';

class VillaMiniCard extends StatelessWidget {
  const VillaMiniCard({super.key, required this.villaCardModuleInfo});
  final VillaCardModuleInfo villaCardModuleInfo;

  @override
  Widget build(BuildContext context) {
    return PropertyMiniCard(
      propertyType: 'villa',
      propertyTypeIcon: 'assets/images/Mansion.png',
      changingDataText: villaCardModuleInfo.garden ? 'garden' : 'no gardens',
      changingDataTextIcon: 'assets/images/Garden.png',
      propertyCardModuleInfo: villaCardModuleInfo,
    );
  }
}

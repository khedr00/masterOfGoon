import 'package:flutter/material.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/prpoperty_card_info/property_card_model.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/property_mini_card.dart';

class StoreMiniCard extends StatelessWidget {
  const StoreMiniCard({super.key, required this.storeCardModuleInfo});
  final PropertyCardModel storeCardModuleInfo;

  @override
  Widget build(BuildContext context) {
    return PropertyMiniCard(
      propertyType: 'store',
      propertyTypeIcon: 'assets/images/Shop-kind.png',
      changingDataText:
          //  storeCardModuleInfo.interface,
          'interface',
      changingDataTextIcon: 'assets/images/Closed Sign.png',
      propertyCardModuleInfo: storeCardModuleInfo,
    );
  }
}

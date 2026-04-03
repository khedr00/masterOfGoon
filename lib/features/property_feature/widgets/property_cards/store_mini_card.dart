import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/store_card_module_info.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/property_mini_card.dart';

class StoreMiniCard extends StatelessWidget {
  const StoreMiniCard({super.key, required this.storeCardModuleInfo});
  final StoreCardModuleInfo storeCardModuleInfo;

  @override
  Widget build(BuildContext context) {
    return PropertyMiniCard(
      propertyType: 'store',
      propertyTypeIcon: 'assets/images/Shop-kind.png',
      changingDataText: storeCardModuleInfo.interface,
      changingDataTextIcon: 'assets/images/Closed Sign.png',
      propertyCardModuleInfo: storeCardModuleInfo,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/appartment_card_module_info.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/property_mini_card.dart';

class ApartmentMiniCard extends StatelessWidget {
  const ApartmentMiniCard({super.key, required this.apartmentCardModuleInfo});
  final ApartmentCardModuleInfo apartmentCardModuleInfo;

  @override
  Widget build(BuildContext context) {
    return PropertyMiniCard(
      propertyType: 'aprmnt',
      propertyTypeIcon: 'assets/images/apartment-kind.png',
      changingDataText: apartmentCardModuleInfo.elevator
          ? 'elevator'
          : 'no elevator',
      changingDataTextIcon: 'assets/images/Elevator Doors.png',
      propertyCardModuleInfo: apartmentCardModuleInfo,
    );
  }
}

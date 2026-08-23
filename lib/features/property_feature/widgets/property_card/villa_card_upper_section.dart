import 'package:flutter/material.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/property_info_with_primary_images/villa_info_with_primary_images.dart';
import 'package:untitled1/features/property_feature/widgets/property_card/property_card_upper_section.dart';

class VillaCardUpperSection extends StatelessWidget {
  const VillaCardUpperSection({
    super.key,
    required this.villaInfoWithPrimaryImages,
  });
  final VillaInfoWithPrimaryImages villaInfoWithPrimaryImages;

  @override
  Widget build(BuildContext context) {
    return PropertyCardUpperSection(
      propertyInfo: villaInfoWithPrimaryImages,
      outDoorPlaces: villaInfoWithPrimaryImages.outDoorPlace,
      hasMoreThanOneFloor: true,
      floor: villaInfoWithPrimaryImages.numberOfFloors,
      elevator: false,
      buildingBarking: false,
      storeFront: SizedBox(),
    );
  }
}

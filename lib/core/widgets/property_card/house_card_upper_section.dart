import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/property_info_with_primary_images/house_info_with_primary_images.dart';
import 'package:untitled1/core/widgets/property_card/property_card_upper_section.dart';

class HouseCardUpperSection extends StatelessWidget {
  const HouseCardUpperSection({
    super.key,
    required this.houseInfoWithPrimaryImages,
  });
  final HouseInfoWithPrimaryImages houseInfoWithPrimaryImages;

  @override
  Widget build(BuildContext context) {
    return PropertyCardUpperSection(
      propertyInfo: houseInfoWithPrimaryImages,
      outDoorPlaces: houseInfoWithPrimaryImages.outDoorPlace,
      hasMoreThanOneFloor: true,
      floor: houseInfoWithPrimaryImages.numberOfFloors,
      elevator: false,
      buildingBarking: false,
      storeFront: SizedBox(),
    );
  }
}

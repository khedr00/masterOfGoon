import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/property_info_with_primary_images/hall_info_with_primary_images.dart';
import 'package:untitled1/core/widgets/property_card/property_card_upper_section.dart';

class HallCardUpperSection extends StatelessWidget {
  const HallCardUpperSection({
    super.key,
    required this.hallInfoWithPrimaryImages,
  });
  final HallInfoWithPrimaryImages hallInfoWithPrimaryImages;

  @override
  Widget build(BuildContext context) {
    return PropertyCardUpperSection(
      propertyInfo: hallInfoWithPrimaryImages,
      outDoorPlaces: [],
      hasMoreThanOneFloor: false,
      floor: hallInfoWithPrimaryImages.floorNumber,
      elevator: false,
      buildingBarking: false,
      storeFront: SizedBox(),
    );
  }
}

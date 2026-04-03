import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/property_info_with_primary_images/store_info_with_primary_images.dart';
import 'package:untitled1/core/widgets/property_card/property_card_upper_section.dart';
import 'package:untitled1/core/widgets/property_card/tabable_property_icon.dart';

class StoreCardUpperSection extends StatelessWidget {
  const StoreCardUpperSection({
    super.key,
    required this.storeInfoWithPrimaryImages,
  });
  final StoreInfoWithPrimaryImages storeInfoWithPrimaryImages;

  @override
  Widget build(BuildContext context) {
    return PropertyCardUpperSection(
      propertyInfo: storeInfoWithPrimaryImages,
      outDoorPlaces: [],
      hasMoreThanOneFloor: false,
      floor: storeInfoWithPrimaryImages.floorNumber,
      elevator: false,
      buildingBarking: false,
      storeFront: TabablePropertyIcon(
        image: 'assets/images/Closed Sign.png',
        text: 'Store front',
      ),
    );
  }
}

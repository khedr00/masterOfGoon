import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/property_info_with_primary_images/apartment_info_with_primary_images.dart';
import 'package:untitled1/core/widgets/property_card/property_card_upper_section.dart';

class ApartmentCardUpperSection extends StatelessWidget {
  const ApartmentCardUpperSection({
    super.key,
    required this.apartmentInfoWithPrimaryImages,
  });
  final ApartmentInfoWithPrimaryImages apartmentInfoWithPrimaryImages;

  @override
  Widget build(BuildContext context) {
    return PropertyCardUpperSection(
      propertyInfo: apartmentInfoWithPrimaryImages,
      outDoorPlaces: [],
      hasMoreThanOneFloor: false,
      floor: apartmentInfoWithPrimaryImages.floorNumber,
      elevator: apartmentInfoWithPrimaryImages.elevator,
      buildingBarking: apartmentInfoWithPrimaryImages.buildingParking,
      storeFront: SizedBox(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/get_prop_info_with_prim_images.dart';
import 'package:untitled1/back_end_test/properties/modules/property_info_with_primary_images/apartment_info_with_primary_images.dart';
import 'package:untitled1/back_end_test/properties/modules/property_info_with_primary_images/hall_info_with_primary_images.dart';
import 'package:untitled1/back_end_test/properties/modules/property_info_with_primary_images/house_info_with_primary_images.dart';
import 'package:untitled1/back_end_test/properties/modules/property_info_with_primary_images/villa_info_with_primary_images.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/property_card/apartment_card_upper_section.dart';
import 'package:untitled1/core/widgets/property_card/hall_card_upper_section.dart';
import 'package:untitled1/core/widgets/property_card/house_card_upper_section.dart';
import 'package:untitled1/core/widgets/property_card/property_card_lower_section.dart';
import 'package:untitled1/core/widgets/property_card/store_card_upper_section.dart';
import 'package:untitled1/core/widgets/property_card/villa_card_upper_section.dart';

class PropertyCard extends StatefulWidget {
  const PropertyCard({super.key});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  dynamic _propertyInfo;
  void _getPropertyInfo() async {
    dynamic propertyInfo = await getPropertyInfoWithPrimaryImages(id: 5);
    setState(() {
      _propertyInfo = propertyInfo;
    });
  }

  @override
  void initState() {
    _getPropertyInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (_propertyInfo == null) {
      return Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Stack(
      children: [
        Container(
          width: width * (866 / 1920),
          height: width * (885 / 1920),
          color: backGroundColor,
          child: Column(
            children: [
              // اول قسم اساسي من فوق
              _propertyInfo is HouseInfoWithPrimaryImages
                  ? HouseCardUpperSection(
                      houseInfoWithPrimaryImages: _propertyInfo!,
                    )
                  : _propertyInfo is HallInfoWithPrimaryImages
                  ? HallCardUpperSection(
                      hallInfoWithPrimaryImages: _propertyInfo!,
                    )
                  : _propertyInfo is VillaInfoWithPrimaryImages
                  ? VillaCardUpperSection(
                      villaInfoWithPrimaryImages: _propertyInfo!,
                    )
                  : _propertyInfo is ApartmentInfoWithPrimaryImages
                  ? ApartmentCardUpperSection(
                      apartmentInfoWithPrimaryImages: _propertyInfo!,
                    )
                  : StoreCardUpperSection(
                      storeInfoWithPrimaryImages: _propertyInfo,
                    ),
              // تاني قسم رئيسي من تحت
              PropertyCardLowerSection(),
            ],
          ),
        ),

        Positioned(
          bottom: 0,
          left: width * (10 / 1920),
          child: Container(
            width: width * (168 / 1920),
            height: width * (143 / 1920),
            decoration: BoxDecoration(
              color: fourthColorPrimaryBrown,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * (10 / 1920)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

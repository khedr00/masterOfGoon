import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/data/models/property_api_model.dart';
import 'package:untitled1/features/property_feature/widgets/property_card/property_card_lower_section.dart';
import 'package:untitled1/features/property_feature/widgets/property_card/property_card_upper_section.dart';
import 'package:untitled1/features/property_feature/providers/property_data_provider.dart';
import 'package:untitled1/providers/theme_provider.dart';

class PropertyCard extends StatefulWidget {
  const PropertyCard({super.key, this.propertyId});
  final String? propertyId;

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  @override
  void initState() {
    super.initState();
    if (widget.propertyId != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<PropertyDataProvider>().selectProperty(
          widget.propertyId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    final propertyData = context.watch<PropertyDataProvider>();
    final property = propertyData.property;
    if (property == null) {
      return Container(
        color: getCardColor(themeProvider.isDarkMode),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    final lowerStackInfo = _lowerStackInfo(propertyData, property);
    return Stack(
      children: [
        Container(
          width: width * (866 / 1920),
          height: width * (885 / 1920),
          color: themeProvider.isDarkMode
              ? darkBackGroundColor
              : backGroundColor,
          child: Column(
            children: [
              // اول قسم اساسي من فوق
              PropertyCardUpperSection(property: property),
              // تاني قسم رئيسي من تحت
              const PropertyCardLowerSection(),
            ],
          ),
        ),

        Positioned(
          top: width * (742 / 1920),
          left: width * (10 / 1920),
          child: Container(
            width: width * (168 / 1920),
            height: width * (143 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode
                  ? darkFourthColorPrimaryBrown
                  : fourthColorPrimaryBrown,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: lowerStackInfo == null
                ? null
                : _LowerStackInfoContent(
                    info: lowerStackInfo,
                    isDarkMode: themeProvider.isDarkMode,
                    width: width,
                  ),
          ),
        ),
      ],
    );
  }
}

_LowerStackInfo? _lowerStackInfo(
  PropertyDataProvider propertyData,
  PropertyApiModel property,
) {
  switch (propertyData.imageContext) {
    case PropertyImageContext.room:
      return _LowerStackInfo(image: 'assets/images/Room.png', label: 'Rooms');
    case PropertyImageContext.outdoor:
      return _LowerStackInfo(
        image: 'assets/images/Garden.png',
        count: property.outdoorItems.length,
        label: property.outdoorItems.length == 1 ? 'Outdoor' : 'Outdoors',
      );
    case PropertyImageContext.painting:
      return null;
    case PropertyImageContext.property:
      return null;
  }
}

class _LowerStackInfo {
  const _LowerStackInfo({required this.image, required this.label, this.count});

  final String image;
  final int? count;
  final String label;
}

class _LowerStackInfoContent extends StatelessWidget {
  const _LowerStackInfoContent({
    required this.info,
    required this.isDarkMode,
    required this.width,
  });

  final _LowerStackInfo info;
  final bool isDarkMode;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * (10 / 1920)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * (46 / 1920),
            height: width * (46 / 1920),
            child: Image.asset(info.image),
          ),
          SizedBox(height: width * (6 / 1920)),

          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              info.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: getTextColor(isDarkMode),
                fontFamily: 'NunitoSans-SemiBold',
                fontSize: width * (20 / 1920),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

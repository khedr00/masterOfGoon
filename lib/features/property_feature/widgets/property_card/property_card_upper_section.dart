import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/features/property_feature/data/models/property_api_model.dart';
import 'package:untitled1/features/property_feature/providers/property_data_provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/widgets/property_card/tabable_property_icon.dart';
import 'package:untitled1/providers/theme_provider.dart';

class PropertyCardUpperSection extends StatelessWidget {
  const PropertyCardUpperSection({super.key, required this.property});
  final PropertyApiModel property;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final propertyData = context.watch<PropertyDataProvider>();
    final outDoorPlaces = property.outdoorItems;
    final hasMoreThanOneFloor = property.numOfFloors > 1;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width * (866 / 1920),
          height: width * (638 / 1920),
          color: getCardColor(themeProvider.isDarkMode),
          child: Center(
            child: Container(
              width: width * (846 / 1920),
              height: width * (618 / 1920),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * (5 / 1920)),
                color: themeProvider.isDarkMode
                    ? darkFourthColorSecondaryLightBrown
                    : fourthColorSecondaryLightBrown,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: width * (85 / 1920),
                    child: Row(
                      children: [
                        // فيلر اول من فوق عاليسار
                        Container(
                          width: width * (652 / 1920),
                          decoration: BoxDecoration(
                            color: getCardColor(themeProvider.isDarkMode),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(width * (5 / 1920)),
                            ),
                          ),
                        ),
                        // for sale
                        SizedBox(
                          width: width * (194 / 1920),
                          height: width * (85 / 1920),
                          child: Center(
                            child: Text(
                              property.listingType.isNotEmpty
                                  ? _enumLabel(property.listingType)
                                  : 'for Sale',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: getPrimaryTextColor(
                                  themeProvider.isDarkMode,
                                ),
                                fontFamily: 'NunitoSans-ExtraBold',
                                fontSize: width * (32 / 1920),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * (151 / 1920),
                    child: Row(
                      children: [
                        Container(
                          width: width * (137 / 1920),
                          color: getCardColor(themeProvider.isDarkMode),
                        ),
                        // شرح العقار الزيادة
                        SizedBox(
                          width: width * (709 / 1920),
                          child: Center(
                            child: Text(
                              property.fullDescription,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: getPrimaryTextColor(
                                  themeProvider.isDarkMode,
                                ),
                                fontFamily: 'NunitoSans-Medium',
                                fontSize: width * (28 / 1920),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * (154 / 1920),
                    child: Row(
                      children: [
                        Container(
                          width: width * (215 / 1920),
                          decoration: BoxDecoration(
                            color: getCardColor(themeProvider.isDarkMode),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(width * (5 / 1920)),
                            ),
                          ),
                        ),
                        // هون المعلومات الأساسية اللي جاي بالنص
                        SizedBox(
                          width: width * (631 / 1920),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _UpperFeatureRow(
                                width: width,
                                children: [
                                  TabablePropertyIcon(
                                    image: 'assets/images/Room.png',
                                    text: 'Rooms',
                                    showClickableState: true,
                                    onTap: () => propertyData.selectRoom(null),
                                  ),
                                  if (outDoorPlaces.isNotEmpty)
                                    TabablePropertyIcon(
                                      image: 'assets/images/Garden.png',
                                      text: 'Outdoors',
                                      showClickableState: true,
                                      onTap: () =>
                                          propertyData.selectOutdoorItem(null),
                                    ),
                                ],
                              ),
                              _UpperFeatureRow(
                                width: width,
                                children: [
                                  if (property.elevator)
                                    TabablePropertyIcon(
                                      image: 'assets/images/Elevator Doors.png',
                                      text: 'Elevator',
                                    ),
                                  if (property.parking)
                                    TabablePropertyIcon(
                                      image: 'assets/images/Parking.png',
                                      text: 'Building parking',
                                    ),
                                  if (property.type.toUpperCase() == 'STORE')
                                    TabablePropertyIcon(
                                      image: 'assets/images/Closed Sign.png',
                                      text: 'Store front',
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // هاد افيه معلومات نهائي
                  SizedBox(
                    height: width * (35 / 1920),
                    child: Row(
                      children: [
                        Container(
                          width: width * (215 / 1920),
                          decoration: BoxDecoration(
                            color: getCardColor(themeProvider.isDarkMode),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(width * (5 / 1920)),
                            ),
                          ),
                        ),
                        SizedBox(width: width * (327 / 1920)),
                        Container(
                          width: width * (304 / 1920),
                          decoration: BoxDecoration(
                            color: getCardColor(themeProvider.isDarkMode),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width * (5 / 1920)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * (193 / 1920),
                    child: Row(
                      children: [
                        // هون الأوتدور وهيك
                        SizedBox(
                          width: width * (542 / 1920),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TabablePropertyIcon(
                                    image: 'assets/images/Square Border.png',
                                    text: '${property.sqft}M',
                                  ),
                                  TabablePropertyIcon(
                                    image: 'assets/images/Closet.png',
                                    text: property.furnishing,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TabablePropertyIcon(
                                    image: 'assets/images/Parking.png',
                                    text: _carsLabel(property.garageCars),
                                  ),
                                  TabablePropertyIcon(
                                    image: hasMoreThanOneFloor
                                        ? 'assets/images/Stairs Up.png'
                                        : 'assets/images/floor.png',
                                    text: hasMoreThanOneFloor
                                        ? '${property.numOfFloors} floors'
                                        : '${property.floorNumber}d floor',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width * (304 / 1920),
                          color: getCardColor(themeProvider.isDarkMode),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: width * (137 / 1920),
            height: width * (58 / 1920),
            decoration: BoxDecoration(
              color: fourthColorPrimaryBrown,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * (50 / 1920),
                  height: width * (50 / 1920),
                  child: Image.asset(_propertyIcon(property.type)),
                ),
                Text(
                  _enumLabel(property.type),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: getTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (24 / 1920),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: width * (67 / 1920),
          left: width * (10 / 1920),
          child: Container(
            width: width * (127 / 1920),
            height: width * (178 / 1920),
            decoration: BoxDecoration(
              color: fourthColorSecondaryLightBrown,
              borderRadius: BorderRadius.circular(width * (10 / 1920)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * (90 / 1920),
                  height: width * (90 / 1920),
                  child: Image.asset(
                    'assets/images/Map with marked location.png',
                  ),
                ),
                Text(
                  property.address,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Regular',
                    fontSize: width * (18 / 1920),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: width * (255 / 1920),
          left: 0,
          child: Container(
            width: width * (215 / 1920),
            height: width * (169 / 1920),
            decoration: BoxDecoration(
              color: fourthColorPrimaryBrown,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * (10 / 1920)),
                bottomRight: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * (30 / 1920),
                      height: width * (30 / 1920),
                      child: Image.asset('assets/images/Price Tag USD.png'),
                    ),
                    Text(
                      '${property.listedPrice} \$',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getTextColor(themeProvider.isDarkMode),
                        fontFamily: 'NunitoSans-ExtraBold',
                        fontSize: width * (20 / 1920),
                      ),
                    ),
                  ],
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     SizedBox(
                //       width: width * (30 / 1920),
                //       height: width * (30 / 1920),
                //       child: Image.asset(
                //         property.isAvailable == true
                //             ? 'assets/images/Check Mark.png'
                //             : 'assets/images/Cancel.png',
                //       ),
                //     ),
                //     Text(
                //       'Available',
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         color: getTextColor(themeProvider.isDarkMode),
                //         fontFamily: 'NunitoSans-Medium',
                //         fontSize: width * (20 / 1920),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
        Positioned(
          top: width * (410 / 1920),
          right: 0,
          child: Container(
            width: width * (304 / 1920),
            height: width * (218 / 1920),
            decoration: BoxDecoration(
              color: fourthColorPrimaryBrown,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * (10 / 1920)),
                bottomLeft: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Near By :',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: getTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (28 / 1920),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * (5 / 1920)),
                  child: SizedBox(
                    height: width * (175 / 1920),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3,
                        crossAxisCount: 2,
                      ),
                      itemCount: property.nearbyPlaces.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: width * (150 / 1920),
                          child: Center(
                            child: Text(
                              '${property.nearbyPlaces[index].name} ${property.nearbyPlaces[index].distance}M',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: getCardColor(themeProvider.isDarkMode),
                                fontFamily: 'NunitoSans-Regular',
                                fontSize: width * (20 / 1920),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: width * (10 / 1920),
          left: width * (147 / 1920),
          child: Container(
            width: width * (390 / 1920),
            height: width * (75 / 1920),
            decoration: BoxDecoration(
              color: fourthColorSecondaryLightBrown,
              borderRadius: BorderRadius.circular(width * (10 / 1920)),
            ),
            child: Center(
              child: Text(
                property.simpleDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: getPrimaryTextColor(themeProvider.isDarkMode),
                  fontFamily: 'NunitoSans-Black',
                  fontSize: width * (36 / 1920),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: width * (547 / 1920),
          child: Container(
            width: width * (105 / 1920),
            height: width * (85 / 1920),
            decoration: BoxDecoration(
              color: fourthColorPrimaryBrown,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(width * (10 / 1920)),
                bottomLeft: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: Center(
              child: Text(
                property.referenceCode,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NunitoSans-BlackItalic',
                  fontSize: width * (28 / 1920),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: width * (95 / 1920),
          left: width * (547 / 1920),
          child: Tooltip(
            message: 'Copy property ID',
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(width * (10 / 1920)),
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: property.id));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Property ID copied')),
                    );
                  }
                },
                child: Container(
                  width: width * (289 / 1920),
                  height: width * (48 / 1920),
                  padding: EdgeInsets.symmetric(horizontal: width * (12 / 1920)),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(width * (10 / 1920)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'ID: ${property.id}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: getPrimaryTextColor(themeProvider.isDarkMode),
                            fontFamily: 'NunitoSans-Medium',
                            fontSize: width * (18 / 1920),
                          ),
                        ),
                      ),
                      SizedBox(width: width * (8 / 1920)),
                      Icon(
                        Icons.copy_outlined,
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                        size: width * (22 / 1920),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UpperFeatureRow extends StatelessWidget {
  const _UpperFeatureRow({required this.width, required this.children});

  final double width;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return SizedBox(height: width * (60 / 1920));

    return SizedBox(
      width: width * (611 / 1920),
      height: width * (60 / 1920),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final child in children) ...[
              child,
              SizedBox(width: width * (14 / 1920)),
            ],
          ],
        ),
      ),
    );
  }
}

String _propertyIcon(String type) {
  switch (type.toUpperCase()) {
    case 'VILLA':
      return 'assets/images/Mansion.png';
    case 'STORE':
      return 'assets/images/Shop-kind.png';
    case 'HALL':
      return 'assets/images/City Hall.png';
    case 'APARTMENT':
      return 'assets/images/apartment-kind.png';
    default:
      return 'assets/images/house_kind.png';
  }
}

String _carsLabel(int? cars) {
  final count = cars ?? 0;
  return '$count ${count == 1 ? 'Car' : 'Cars'}';
}

String _enumLabel(String value) => value
    .split('_')
    .map(
      (part) => part.isEmpty
          ? part
          : '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}',
    )
    .join(' ');

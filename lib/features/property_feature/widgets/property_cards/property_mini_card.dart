import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/prpoperty_card_info/property_card_model.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class PropertyMiniCard extends StatelessWidget {
  const PropertyMiniCard({
    super.key,
    required this.propertyType,
    required this.propertyTypeIcon,
    required this.changingDataText,
    required this.changingDataTextIcon,
    required this.propertyCardModuleInfo,
  });
  final String propertyType;
  final String propertyTypeIcon;
  final String changingDataText;
  final String changingDataTextIcon;
  final PropertyCardModel propertyCardModuleInfo;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (381 / 1920),
      height: width * (449 / 1920),
      color: themeProvider.isDarkMode ? darkBackGroundColor : backGroundColor,
      child: Center(
        child: Container(
          width: width * (357 / 1920),
          height: width * (449 / 1920),
          decoration: BoxDecoration(
            color: getCardColor(themeProvider.isDarkMode),
            boxShadow: [
              BoxShadow(
                color: fourthColorPrimaryBrown,
                spreadRadius: width * (2 / 1920),
                blurRadius: width * (3 / 1920),
              ),
            ],
            border: Border.all(
              color: fourthColorPrimaryBrown,
              width: width * (2 / 1920),
            ),
            borderRadius: BorderRadius.circular(width * (30 / 1920)),
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: width * (251 / 1920),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * (30 / 1920)),
                    topRight: Radius.circular(width * (30 / 1920)),
                  ),
                  child: Image.asset(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    'assets/images/test_photos/property_primary_photo.png',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: width * (5 / 1920)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width * (137 / 1920),
                      height: width * (39 / 1920),
                      decoration: BoxDecoration(
                        color: fourthColorPrimaryBrown,
                        borderRadius: BorderRadius.circular(width * (5 / 1920)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            propertyTypeIcon,
                            // 'assets/images/Mansion.png'
                            width: width * (39 / 1920),
                            height: width * (39 / 1920),
                          ),
                          Text(
                            propertyType,
                            // 'Villa'
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NunitoSans-Bold',
                              fontSize: width * (24 / 1920),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * (105 / 1920),
                      height: width * (39 / 1920),
                      decoration: BoxDecoration(
                        color: fourthColorPrimaryBrown,
                        borderRadius: BorderRadius.circular(width * (5 / 1920)),
                      ),
                      child: Center(
                        child: Text(
                          propertyCardModuleInfo.referenceCode,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NunitoSans-BlackItalic',
                            fontSize: width * (24 / 1920),
                          ),
                        ),
                      ),
                    ),
                    // Image.asset(
                    //   propertyCardModuleInfo.avaliableInternet
                    //       ? 'assets/images/Wi-Fi.png'
                    //       : 'assets/images/Wi-Fi off.png',
                    //   width: width * (41 / 1920),
                    //   height: width * (41 / 1920),
                    // ),
                  ],
                ),
              ),
              Row(
                children: [
                  Spacer(flex: 3),
                  Image.asset(
                    'assets/images/Price Tag USD.png',
                    width: width * (30 / 1920),
                    height: width * (30 / 1920),
                  ),
                  Spacer(flex: 1),
                  Text(
                    '${propertyCardModuleInfo.listedPrice}\$',
                    style: TextStyle(
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: width * (20 / 1920),
                    ),
                  ),
                  Spacer(flex: 5),
                  Image.asset(
                    changingDataTextIcon,
                    // 'assets/images/Star.png'
                    width: width * (30 / 1920),
                    height: width * (30 / 1920),
                  ),
                  Spacer(flex: 1),
                  Text(
                    changingDataText,
                    style: TextStyle(
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: width * (20 / 1920),
                    ),
                  ),
                  Spacer(flex: 3),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: width * (5 / 1920)),
                child: Row(
                  children: [
                    Spacer(flex: 3),
                    Image.asset(
                      'assets/images/Sofa.png',
                      width: width * (30 / 1920),
                      height: width * (30 / 1920),
                    ),
                    Spacer(flex: 1),
                    Text(
                      '${propertyCardModuleInfo.numOfRooms.toString()} Rooms',
                      style: TextStyle(
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                        fontFamily: 'NunitoSans-Regular',
                        fontSize: width * (20 / 1920),
                      ),
                    ),
                    Spacer(flex: 5),
                    Image.asset(
                      'assets/images/House.png',
                      width: width * (30 / 1920),
                      height: width * (30 / 1920),
                    ),
                    Spacer(flex: 1),
                    Text(
                      '${propertyCardModuleInfo.sqft.toString()} M',
                      style: TextStyle(
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                        fontFamily: 'NunitoSans-Regular',
                        fontSize: width * (20 / 1920),
                      ),
                    ),
                    Spacer(flex: 3),
                  ],
                ),
              ),
              Container(
                width: width * (375 / 1920),
                height: width * (10 / 1920),
                color: themeProvider.isDarkMode
                    ? darkBackGroundColor
                    : backGroundColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        propertyCardModuleInfo.simpleDescription,
                        style: TextStyle(
                          fontFamily: 'NunitoSans-ExtraBold',
                          fontSize: width * (22 / 1920),
                          color: getPrimaryTextColor(themeProvider.isDarkMode),
                        ),
                      ),
                      Text(
                        propertyCardModuleInfo.city,
                        style: TextStyle(
                          fontFamily: 'NunitoSans-Regular',
                          fontSize: width * (18 / 1920),
                          color: getPrimaryTextColor(themeProvider.isDarkMode),
                        ),
                      ),
                    ],
                  ),
                  // Image.asset(
                  //   propertyCardModuleInfo.isAvalable
                  //       ? 'assets/images/Check Mark.png'
                  //       : 'assets/images/Cancel.png',
                  //   width: width * (55 / 1920),
                  //   height: width * (55 / 1920),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

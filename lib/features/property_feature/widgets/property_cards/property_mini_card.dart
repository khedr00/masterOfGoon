import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/property_card_module_info.dart';
import 'package:untitled1/core/widgets/constants.dart';

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
  final PropertyCardModuleInfo propertyCardModuleInfo;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (381 / 1920),
      height: width * (449 / 1920),
      color: backGroundColor,
      child: Center(
        child: Container(
          width: width * (357 / 1920),
          height: width * (449 / 1920),
          decoration: BoxDecoration(
            color: Colors.white,
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
                          propertyCardModuleInfo.nameCode,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NunitoSans-BlackItalic',
                            fontSize: width * (24 / 1920),
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      propertyCardModuleInfo.avaliableInternet
                          ? 'assets/images/Wi-Fi.png'
                          : 'assets/images/Wi-Fi off.png',
                      width: width * (41 / 1920),
                      height: width * (41 / 1920),
                    ),
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
                    '${propertyCardModuleInfo.leastSellPrice}\$',
                    style: TextStyle(
                      color: Colors.black,
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
                      color: Colors.black,
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
                      '${propertyCardModuleInfo.numberOfRooms.toString()} Rooms',
                      style: TextStyle(
                        color: Colors.black,
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
                        color: Colors.black,
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
                color: backGroundColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        propertyCardModuleInfo.simplePropertyDescription,
                        style: TextStyle(
                          fontFamily: 'NunitoSans-ExtraBold',
                          fontSize: width * (22 / 1920),
                        ),
                      ),
                      Text(
                        propertyCardModuleInfo.address,
                        style: TextStyle(
                          fontFamily: 'NunitoSans-Regular',
                          fontSize: width * (18 / 1920),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    propertyCardModuleInfo.isAvalable
                        ? 'assets/images/Check Mark.png'
                        : 'assets/images/Cancel.png',
                    width: width * (55 / 1920),
                    height: width * (55 / 1920),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

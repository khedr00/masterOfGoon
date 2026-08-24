import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/widgets/property_card/property_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_photos_shower/property_photos_shower_widget.dart';
import 'package:untitled1/features/submanager/widgets/choose_employee/choose_employee_widget.dart';
import 'package:untitled1/providers/theme_provider.dart';

class RightSideOfSmHome extends StatefulWidget {
  const RightSideOfSmHome({super.key, required this.propertyId});
  final String propertyId;

  @override
  State<RightSideOfSmHome> createState() => _RightSideOfSmHomeState();
}

class _RightSideOfSmHomeState extends State<RightSideOfSmHome> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: width * (15 / 1920)),
          child: Container(
            width: width * (200 / 1920),
            height: width * (40 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
              borderRadius: BorderRadius.circular(width * (5 / 1920)),
              boxShadow: [
                BoxShadow(
                  color: themeProvider.isDarkMode
                      ? darkPrimaryColor
                      : primaryColor,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Lead Info :',
                style: TextStyle(
                  color: getTextColor(themeProvider.isDarkMode),
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (20 / 1920),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: width * (1120 / 1920),
          height: width * (200 / 1920),
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode
                ? darkSecondaryColor
                : secondaryColor,
            borderRadius: BorderRadius.circular(width * (5 / 1920)),
            boxShadow: [
              BoxShadow(
                color: themeProvider.isDarkMode
                    ? darkSecondaryColor
                    : secondaryColor,
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: width * (189 / 1920),
                        height: width * (200 / 1920),
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode
                              ? darkSecondaryColor
                              : secondaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(width * (10 / 1920)),
                            bottomLeft: Radius.circular(width * (10 / 1920)),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: width * (80 / 1920),
                              child: SizedBox(
                                width: width * (100 / 1920),
                                height: width * (100 / 1920),
                                child: Image.asset(
                                  'assets/images/profilePhoto-icon.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * (189 / 1920),
                              height: width * ((200 - 80) / 1920),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Khedr Issa',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans-Bold',
                                      fontSize: width * (22 / 1920),
                                    ),
                                  ),
                                  Text(
                                    'lead Scoring: 86%',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans-Regular',
                                      fontSize: width * (18 / 1920),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(width * (5 / 1920)),
                        width: width * (170 / 1920),
                        height: width * (140 / 1920),
                        decoration: BoxDecoration(
                          color: getCardColor(themeProvider.isDarkMode),
                          borderRadius: BorderRadius.circular(
                            width * (10 / 1920),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'I would like to know more about this property',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: getPrimaryTextColor(
                                themeProvider.isDarkMode,
                              ),
                              fontFamily: 'NunitoSans-SemiBold',
                              fontSize: width * (14 / 1920),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(width * (10 / 1920)),
                child: Container(
                  width: width * (1 / 1920),
                  height: width * (200 / 1920),
                  color: getDividerColor(themeProvider.isDarkMode),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Convertion Probability : 79%',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (22 / 1920),
                    ),
                  ),
                  Text(
                    'Expected revenue : 1100\$',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (22 / 1920),
                    ),
                  ),
                  Text(
                    'Budget : 17000\$',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (22 / 1920),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(width * (10 / 1920)),
                child: Container(
                  width: width * (1 / 1920),
                  height: width * (200 / 1920),
                  color: getDividerColor(themeProvider.isDarkMode),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Lead Segmentation :',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (22 / 1920),
                    ),
                  ),
                  Text(
                    'Hot',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? darkSixthColorSecondaryLightRed
                          : sixthColorSecondaryLightRed,
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (32 / 1920),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: width * (15 / 1920)),
          child: Container(
            width: width * (200 / 1920),
            height: width * (40 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
              borderRadius: BorderRadius.circular(width * (5 / 1920)),
              boxShadow: [
                BoxShadow(
                  color: themeProvider.isDarkMode
                      ? darkPrimaryColor
                      : primaryColor,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Property Info :',
                style: TextStyle(
                  color: getTextColor(themeProvider.isDarkMode),
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (20 / 1920),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: width * (10 / 1920),
            top: width * (5 / 1920),
          ),
          child: SizedBox(
            height: width * (890 / 1920),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                widget.propertyId == ''
                    ? SizedBox()
                    : PropertyCard(
                        // key: ValueKey(propertyId),
                        propertyId: 'bbae6c38-d791-48b7-84b1-225fd5f96f38',
                      ),
                PropertyPhotosShowerWidget(isPrimaryPropertyPhotos: true),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: width * (15 / 1920)),
          child: Container(
            width: width * (200 / 1920),
            height: width * (40 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
              borderRadius: BorderRadius.circular(width * (5 / 1920)),
              boxShadow: [
                BoxShadow(
                  color: themeProvider.isDarkMode
                      ? darkPrimaryColor
                      : primaryColor,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Choose Employee :',
                style: TextStyle(
                  color: getTextColor(themeProvider.isDarkMode),
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (20 / 1920),
                ),
              ),
            ),
          ),
        ),
        ChooseEmployeeWidget(),
      ],
    );
  }
}

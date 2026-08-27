import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/back_end_test/sales_manager_requests/sales_manager_request_model.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/data/property_image_source.dart';
import 'package:untitled1/features/property_feature/widgets/property_card/property_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_photos_shower/property_photos_shower_widget.dart';
import 'package:untitled1/features/submanager/widgets/choose_employee/choose_employee_widget.dart';
import 'package:untitled1/providers/theme_provider.dart';

class RightSideOfSmHome extends StatefulWidget {
  const RightSideOfSmHome({
    super.key,
    required this.userAuthInfo,
    required this.dealRequest,
  });

  final UserAuthInfo userAuthInfo;
  final DealRequestCardInfo dealRequest;

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
                'Client Info :',
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
          width: width * (760 / 1920),
          height: width * (150 / 1920),
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
                        width: width * (170 / 1920),
                        height: width * (150 / 1920),
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
                              height: width * (65 / 1920),
                              child: SizedBox(
                                width: width * (70 / 1920),
                                height: width * (70 / 1920),
                                child: PropertyImageSource.image(
                                  PropertyImageSource.normalize(
                                    widget.dealRequest.clientPhoto,
                                    'assets/images/profilePhoto-icon.png',
                                  ),
                                  'assets/images/profilePhoto-icon.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * (170 / 1920),
                              height: width * ((150 - 65) / 1920),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    widget.dealRequest.clientName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans-Bold',
                                      fontSize: width * (22 / 1920),
                                      color: getPrimaryTextColor(
                                        themeProvider.isDarkMode,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: width * (5 / 1920)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(width * (5 / 1920)),
                        width: width * (210 / 1920),
                        height: width * (95 / 1920),
                        decoration: BoxDecoration(
                          color: getCardColor(themeProvider.isDarkMode),
                          borderRadius: BorderRadius.circular(
                            width * (10 / 1920),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.dealRequest.message.isEmpty
                                ? 'I would like to know more about this property'
                                : widget.dealRequest.message,
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
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
                  height: width * (130 / 1920),
                  color: getDividerColor(themeProvider.isDarkMode),
                ),
              ),
              Text(
                '${widget.dealRequest.type.toUpperCase()} Request',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: getPrimaryTextColor(themeProvider.isDarkMode),
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (24 / 1920),
                ),
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
                widget.dealRequest.id == ''
                    ? SizedBox()
                    : PropertyCard(
                        key: ValueKey(widget.dealRequest.id),
                        propertyId: widget.dealRequest.id,
                      ),
                PropertyPhotosShowerWidget(
                  key: ValueKey('photos-${widget.dealRequest.id}'),
                  isPrimaryPropertyPhotos: true,
                ),
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
                'Create Deal :',
                style: TextStyle(
                  color: getTextColor(themeProvider.isDarkMode),
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (20 / 1920),
                ),
              ),
            ),
          ),
        ),
        ChooseEmployeeWidget(
          key: ValueKey('employees-${widget.dealRequest.id}'),
          userAuthInfo: widget.userAuthInfo,
          dealRequest: widget.dealRequest,
        ),
      ],
    );
  }
}

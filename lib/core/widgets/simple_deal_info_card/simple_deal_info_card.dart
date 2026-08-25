import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class SimpleDealInfoCard extends StatelessWidget {
  const SimpleDealInfoCard({
    super.key,
    required this.dealStage,
    required this.dealTitle,
    required this.dealId,
    required this.dealDate,
    required this.priceRange,
    required this.successRate,
    this.rentalPeriod,
    required this.isBUYRENT,
  });
  final String dealStage;
  final String dealTitle;
  final String dealId;
  final String dealDate;
  final String priceRange;
  final String successRate;
  final int? rentalPeriod;
  final bool isBUYRENT;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width * (407 / 1920),
          height: width * (220 / 1920),
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode
                ? darkBackGroundColor
                : backGroundColor,
          ),
          child: Center(
            child: Container(
              width: width * (387 / 1920),
              height: width * (200 / 1920),
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? darkSecondaryColor
                    : secondaryColor,
              ),
              child: Column(
                children: [
                  // هون موجود اول قسم فوقاني فيه التاريخ و الآي دي و الفلر لأول ستاك
                  SizedBox(
                    width: width * (387 / 1920),
                    height: width * (96 / 1920),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: width * (111 / 1920),
                              height: width * (42 / 1920),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(
                                    width * (10 / 1920),
                                  ),
                                ),
                                color: themeProvider.isDarkMode
                                    ? darkBackGroundColor
                                    : backGroundColor,
                              ),
                            ),
                            SizedBox(
                              width: width * (276 / 1920),
                              height: width * (42 / 1920),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    dealDate,
                                    style: TextStyle(
                                      color: getPrimaryTextColor(
                                        themeProvider.isDarkMode,
                                      ),
                                      fontFamily: 'NunitoSans-MediumItalic',
                                      fontSize: width * (18 / 1920),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * (387 / 1902),
                          height: width * (54 / 1920),
                          child: Center(
                            child: Text(
                              rentalPeriod != null
                                  ? '$priceRange-$rentalPeriod month'
                                  : priceRange,
                              style: TextStyle(
                                color: getPrimaryTextColor(
                                  themeProvider.isDarkMode,
                                ),
                                fontFamily: 'NunitoSans-ExtraBold',
                                fontSize: width * (20 / 1920),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // هون موجود عنوان الديل و الفيلر لتاني ستاك
                  Row(
                    mainAxisAlignment: isBUYRENT
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.end,
                    children: [
                      Container(
                        width: width * (255 / 1920),
                        height: width * (89 / 1920),
                        color: themeProvider.isDarkMode
                            ? darkSecondaryColor
                            : secondaryColor,
                        child: Center(
                          child: Text(
                            'ID : $dealId',
                            style: TextStyle(
                              color: getPrimaryTextColor(
                                themeProvider.isDarkMode,
                              ),
                              fontFamily: 'NunitoSans-Bold',
                              fontSize: width * (18 / 1920),
                            ),
                          ),
                        ),
                      ),
                      isBUYRENT
                          ? SizedBox()
                          : Container(
                              width: width * (129 / 1920),
                              height: width * (89 / 1920),
                              decoration: BoxDecoration(
                                color: themeProvider.isDarkMode
                                    ? darkBackGroundColor
                                    : backGroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(width * (10 / 1920)),
                                  bottomLeft: Radius.circular(
                                    width * (10 / 1920),
                                  ),
                                ),
                              ),
                            ),
                    ],
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
            width: width * (112 / 1920),
            height: width * (43 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * (10 / 1920)),
                bottomRight: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: Center(
              child: Text(
                dealStage,
                style: TextStyle(
                  color: getTextColor(themeProvider.isDarkMode),
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (14 / 1920),
                ),
              ),
            ),
          ),
        ),
        isBUYRENT
            ? SizedBox()
            : Positioned(
                top: width * (114 / 1920),
                right: 0,
                child: Container(
                  width: width * (129 / 1920),
                  height: width * (71 / 1920),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? darkPrimaryColor
                        : primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(width * (10 / 1920)),
                      bottomLeft: Radius.circular(width * (10 / 1920)),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      successRate,
                      style: TextStyle(
                        color: getTextColor(themeProvider.isDarkMode),
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (14 / 1920),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

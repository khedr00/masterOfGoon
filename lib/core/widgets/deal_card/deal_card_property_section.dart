import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class DealCardPropertySection extends StatelessWidget {
  const DealCardPropertySection({
    super.key,
    required this.dealDate,
    required this.dealId,
    required this.propertyPrimaryImage,
    required this.propertyType,
    required this.propertyPrice,
    required this.propertySimpleDescription,
    required this.propertyAddress,
    this.rentalPeriod,
  });
  final String dealDate;
  final String dealId;
  final String propertyPrimaryImage;
  final String propertyType;
  final int propertyPrice;
  final String propertySimpleDescription;
  final String propertyAddress;
  final int? rentalPeriod;

  // PropertyInfoInsideDealCard? _propertyInfoInsideDealCard;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;

    // if (_propertyInfoInsideDealCard == null) {
    //   return Container(
    //     width: width * (550 / 1920),
    //     color: secondaryColor,
    //     child: Center(child: CircularProgressIndicator()),
    //   );
    // }
    return Column(
      children: [
        Row(
          children: [
            // فيلير لمحل الستاك مشان ما تجي فيه عناصر و تختفي تحت الستاك
            Container(
              width: width * (413 / 1920),
              height: width * (79 / 1920),
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? darkSecondaryColor
                    : secondaryColor,
                borderRadius: BorderRadius.circular(width * (10 / 1920)),
              ),
            ),
            SizedBox(
              width: width * (193 / 1920),
              height: width * (79 / 1920),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    dealDate,
                    style: TextStyle(
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                      fontFamily: 'NunitoSans-MediumItalic',
                      fontSize: width * (12 / 1920),
                    ),
                  ),
                  Text(
                    'ID :${dealId.substring(0, 8)}',
                    style: TextStyle(
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                      fontFamily: 'NunitoSans-MediumItalic',
                      fontSize: width * (10 / 1920),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: width * (305 / 1920),
              height: width * (153 / 1920),
              child: Image.network(propertyPrimaryImage),
            ),
            Padding(
              padding: EdgeInsets.only(
                // top: width * (10 / 1920),
                // left: width * (10 / 1920),
              ),
              child: Column(
                children: [
                  Row(
                    children: rentalPeriod == null
                        ? [
                            SizedBox(
                              width: width * (30 / 1920),
                              height: width * (30 / 1920),
                              child: Image.asset(
                                'assets/images/House With a Garden.png',
                              ),
                            ),
                            Text(
                              propertyType.toLowerCase(),
                              style: TextStyle(
                                color: getPrimaryTextColor(
                                  themeProvider.isDarkMode,
                                ),
                                fontFamily: 'NunitoSans-SemiBold',
                                fontSize: width * (18 / 1920),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * (30 / 1920),
                              ),
                              child: SizedBox(
                                width: width * (30 / 1920),
                                height: width * (30 / 1920),
                                child: Image.asset(
                                  'assets/images/Price Tag USD.png',
                                ),
                              ),
                            ),
                            Text(
                              '${propertyPrice.toString()}\$',
                              style: TextStyle(
                                color: getPrimaryTextColor(
                                  themeProvider.isDarkMode,
                                ),
                                fontFamily: 'NunitoSans-SemiBold',
                                fontSize: width * (18 / 1920),
                              ),
                            ),
                          ]
                        : [],
                    //           SizedBox(
                    //             width: width * (25 / 1920),
                    //             height: width * (25 / 1920),
                    //             child: Image.asset(
                    //               'assets/images/House With a Garden.png',
                    //             ),
                    //           ),
                    //           Text(
                    //             propertyType,
                    //             style: TextStyle(
                    //               color: getPrimaryTextColor(
                    //                 themeProvider.isDarkMode,
                    //               ),
                    //               fontFamily: 'NunitoSans-SemiBold',
                    //               fontSize: width * (16 / 1920),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.only(
                    //               left: width * (15 / 1920),
                    //             ),
                    //             child: SizedBox(
                    //               width: width * (25 / 1920),
                    //               height: width * (25 / 1920),
                    //               child: Image.asset(
                    //                 'assets/images/Price Tag USD.png',
                    //               ),
                    //             ),
                    //           ),
                    //           Text(
                    //             '${propertyPrice.toString()} \$',
                    //             style: TextStyle(
                    //               color: getPrimaryTextColor(
                    //                 themeProvider.isDarkMode,
                    //               ),
                    //               fontFamily: 'NunitoSans-SemiBold',
                    //               fontSize: width * (16 / 1920),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.only(
                    //               left: width * (15 / 1920),
                    //             ),
                    //             child: SizedBox(
                    //               width: width * (25 / 1920),
                    //               height: width * (25 / 1920),

                    //               child: Image.asset(
                    //                 'assets/images/Date Span.png',
                    //               ),
                    //             ),
                    //           ),
                    //           Text(
                    //             '${rentalPeriod.toString()} Months',
                    //             style: TextStyle(
                    //               color: getPrimaryTextColor(
                    //                 themeProvider.isDarkMode,
                    //               ),
                    //               fontFamily: 'NunitoSans-SemiBold',
                    //               fontSize: width * (16 / 1920),
                    //             ),
                    //           ),
                    //         ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: width * (10 / 1920),
                      left: width * (20 / 1920),
                    ),
                    child: SizedBox(
                      width: width * (272 / 1920),
                      height: width * (70 / 1920),
                      child: SizedBox(
                        width: width * (256 / 1902),
                        height: width * (60 / 1920),
                        child: Text(
                          propertySimpleDescription.length > 50
                              ? propertySimpleDescription.substring(0, 51)
                              : propertySimpleDescription,
                          style: TextStyle(
                            color: getPrimaryTextColor(
                              themeProvider.isDarkMode,
                            ),
                            fontFamily: 'NunitoSans-Medium',
                            fontSize: width * (18 / 1920),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * (25 / 1920),
                        height: width * (25 / 1920),
                        child: Image.asset('assets/images/Location.png'),
                      ),
                      Text(
                        propertyAddress,
                        style: TextStyle(
                          color: getPrimaryTextColor(themeProvider.isDarkMode),
                          fontFamily: 'NunitoSans-SemiBold',
                          fontSize: width * (13 / 1920),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

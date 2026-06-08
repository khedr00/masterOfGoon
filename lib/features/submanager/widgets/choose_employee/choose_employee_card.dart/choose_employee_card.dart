import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class ChooseEmployeeCard extends StatelessWidget {
  const ChooseEmployeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * (750 / 1920),
      height: width * (200 / 1920),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? darkSecondaryColor : secondaryColor,
        borderRadius: BorderRadius.circular(width * (10 / 1920)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              width * (15 / 1920),
              0,
              width * (15 / 1920),
              0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1, -1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(width * (8 / 1920)),
                    child: Image.asset(
                      'assets/images/profilePhoto-icon.png',
                      width: width * (75 / 1920),
                      height: width * (75 / 1920),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Text(
                  'Khedr issa',
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (20 / 1920),
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                  ),
                ),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        0,
                        0,
                        width * (5 / 1920),
                        0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(width * (8 / 1920)),
                        child: Image.asset(
                          'assets/images/Location.png',
                          width: width * (30 / 1920),
                          height: width * (30 / 1920),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Text(
                      'Homs-shien',
                      style: TextStyle(
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (16 / 1920),
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: width * (180 / 1920),
            child: VerticalDivider(
              thickness: width * (2 / 1920),
              color: getDividerColor(themeProvider.isDarkMode),
            ),
          ),

          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              width * (15 / 1920),
              0,
              width * (15 / 1920),
              0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Productivity : ',
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (20 / 1920),
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                  ),
                ),

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    0,
                    0,
                    0,
                    width * (15 / 1920),
                  ),
                  child: CircularPercentIndicator(
                    percent: 0.63,
                    radius: width * (40 / 1920),
                    lineWidth: width * (12 / 1920),
                    animation: true,
                    animateFromLastPercent: true,
                    progressColor: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
                    backgroundColor: themeProvider.isDarkMode ? darkBackGroundColor : backGroundColor,
                    center: Text(
                      '63%',
                      style: TextStyle(
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (20 / 1920),
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                      ),
                    ),
                  ),
                ),

                Text(
                  'Avg Response Time :',
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (20 / 1920),
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                  ),
                ),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(width * (8 / 1920)),
                      child: Image.asset(
                        'assets/images/Stopwatch.png',
                        width: width * (30 / 1920),
                        height: width * (30 / 1920),
                        fit: BoxFit.cover,
                      ),
                    ),

                    Text(
                      '19 M',
                      style: TextStyle(
                        fontFamily: 'NunitoSans-Regular',
                        fontSize: width * (16 / 1920),
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: width * (180 / 1920),
            child: VerticalDivider(
              thickness: width * (2 / 1920),
              color: getDividerColor(themeProvider.isDarkMode),
            ),
          ),

          Container(
            width: width * (359 / 1920),
            decoration: BoxDecoration(color: themeProvider.isDarkMode ? darkSecondaryColor : secondaryColor),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width * (170 / 1920),
                  height: width * (70 / 1920),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: width * (4 / 1920),
                        color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
                        offset: Offset(0, 0),
                        spreadRadius: width * (2 / 1920),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(width * (5 / 1920)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(width * (8 / 1920)),
                        child: Image.asset(
                          'assets/images/Handshake.png',
                          width: width * (30 / 1920),
                          height: width * (30 / 1920),
                          fit: BoxFit.cover,
                        ),
                      ),

                      Text(
                        '23 Active Deals',
                        style: TextStyle(
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: width * (16 / 1920),
                          color: getTextColor(themeProvider.isDarkMode),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: width * (140 / 1920),
                      height: width * (70 / 1920),
                      decoration: BoxDecoration(
                        color: fifthColorPrimaryGreen,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: width * (4 / 1920),
                            color: fifthColorPrimaryGreen,
                            offset: Offset(0, 0),
                            spreadRadius: width * (2 / 1920),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(width * (5 / 1920)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'successful',
                            style: TextStyle(
                              fontFamily: 'NunitoSans-Bold',
                              fontSize: width * (16 / 1920),
                              color: getTextColor(themeProvider.isDarkMode),
                            ),
                          ),

                          Text(
                            '14',
                            style: TextStyle(
                              fontFamily: 'NunitoSans-Bold',
                              fontSize: width * (22 / 1920),
                              color: getPrimaryTextColor(themeProvider.isDarkMode),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: width * (140 / 1920),
                      height: width * (70 / 1920),
                      decoration: BoxDecoration(
                        color: sixthColorPrimaryRed,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: width * (4 / 1920),
                            color: sixthColorPrimaryRed,
                            offset: Offset(0, 0),
                            spreadRadius: width * (2 / 1920),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(width * (5 / 1920)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Lost',
                            style: TextStyle(
                              fontFamily: 'NunitoSans-Bold',
                              fontSize: width * (16 / 1920),
                              color: getTextColor(themeProvider.isDarkMode),
                            ),
                          ),

                          Text(
                            '9',
                            style: TextStyle(
                              fontFamily: 'NunitoSans-Bold',
                              fontSize: width * (22 / 1920),
                              color: getPrimaryTextColor(themeProvider.isDarkMode),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

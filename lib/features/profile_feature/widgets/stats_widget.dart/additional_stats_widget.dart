import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class AdditionalStatsWidget extends StatelessWidget {
  const AdditionalStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (490 / 1920),
      height: width * (420 / 1920),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: width * (470 / 1920),
            height: width * (85 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
              borderRadius: BorderRadius.circular(width * (5 / 1920)),
              boxShadow: [
                BoxShadow(
                  color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Total number of deals',
                  style: TextStyle(
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (20 / 1920),
                  ),
                ),
                Text(
                  '55',
                  style: TextStyle(
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (38 / 1920),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: width * (229 / 1920),
                height: width * (85 / 1920),
                decoration: BoxDecoration(
                  color: fifthColorPrimaryGreen,
                  borderRadius: BorderRadius.circular(width * (5 / 1920)),
                  boxShadow: [
                    BoxShadow(
                      color: fifthColorPrimaryGreen,
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Successful',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (20 / 1920),
                      ),
                    ),
                    Text(
                      '31',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (38 / 1920),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * (229 / 1920),
                height: width * (85 / 1920),
                decoration: BoxDecoration(
                  color: sixthColorPrimaryRed,
                  borderRadius: BorderRadius.circular(width * (5 / 1920)),
                  boxShadow: [
                    BoxShadow(
                      color: sixthColorPrimaryRed,
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Lost',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (20 / 1920),
                      ),
                    ),
                    Text(
                      '24',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (38 / 1920),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
            width: width * (470 / 1920),
            height: width * (85 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
              borderRadius: BorderRadius.circular(width * (5 / 1920)),
              boxShadow: [
                BoxShadow(
                  color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Deal Success Rate',
                  style: TextStyle(
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (20 / 1920),
                  ),
                ),
                Text(
                  '78 %',
                  style: TextStyle(
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (38 / 1920),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width * (470 / 1920),
            height: width * (85 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
              borderRadius: BorderRadius.circular(width * (5 / 1920)),
              boxShadow: [
                BoxShadow(
                  color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Average time for closing a Deal',
                  style: TextStyle(
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (20 / 1920),
                  ),
                ),
                Text(
                  '5 Days',
                  style: TextStyle(
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (38 / 1920),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/buttons/button.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';
import 'package:untitled1/features/profile_feature/widgets/profile_card_photo_till_the_small_container_section.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width * (411 / 1920),
          height: width * (950 / 1920),
          color: themeProvider.isDarkMode ? darkBackGroundColor : backGroundColor,
          child: Column(
            children: [
              //اول قسم من فوق
              ProfileCardPhotoTillTheSmallContainerSection(),
              // تاني شقفة صغيرة من تحت
              Container(
                width: width * (411 / 1920),
                height: width * (155 / 1920),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode ? darkSecondaryColor : secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(width * (5 / 1920)),
                    bottomRight: Radius.circular(width * (5 / 1920)),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(
                      buttonAction: () {},
                      widthOfButton: width * (204 / 1920),
                      heightOfButton: width * (49 / 1920),
                      borderRadiusOfButton: width * (10 / 1920),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * (40 / 1920),
                            height: width * (40 / 1920),
                            child: Image.asset('assets/images/Settings.png'),
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                              color: getTextColor(themeProvider.isDarkMode),
                              fontFamily: 'NunitoSans-Medium',
                              fontSize: width * (24 / 1920),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Button(
                      buttonAction: () {},
                      widthOfButton: width * (204 / 1920),
                      heightOfButton: width * (49 / 1920),
                      borderRadiusOfButton: width * (10 / 1920),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * (40 / 1920),
                            height: width * (40 / 1920),
                            child: Image.asset('assets/images/Export.png'),
                          ),
                          Text(
                            'Log out',
                            style: TextStyle(
                              color: getTextColor(themeProvider.isDarkMode),
                              fontFamily: 'NunitoSans-Medium',
                              fontSize: width * (24 / 1920),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: width * (141 / 1920),
            height: width * (185 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * (30 / 1920)),
              ),
            ),
            child: Column(
              children: [
                Spacer(flex: 1),
                SizedBox(
                  width: width * (70 / 1920),
                  height: width * (70 / 1920),
                  child: Image.asset('assets/images/Profit.png'),
                ),
                Spacer(flex: 2),
                Text(
                  'Sales',
                  style: TextStyle(
                    color: getTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-ExtraBold',
                    fontSize: width * (24 / 1920),
                  ),
                ),
                Text(
                  'Employee',
                  style: TextStyle(
                    color: getTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (24 / 1920),
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ),
        Positioned(
          top: width * (240 / 1920),
          child: Container(
            width: width * (250 / 1920),
            height: width * (100 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * (5 / 1920)),
                bottomRight: Radius.circular(width * (5 / 1920)),
              ),
            ),
            child: Center(
              child: Text(
                'Khedr issa',
                style: TextStyle(
                  color: getTextColor(themeProvider.isDarkMode),
                  fontFamily: 'NunitoSans-ExtraBold',
                  fontSize: width * (36 / 1920),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: width * (628 / 1920),
          right: 0,
          child: Container(
            width: width * (227 / 1920),
            height: width * (87 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * (5 / 1920)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Total number of Deals',
                  style: TextStyle(
                    color: getTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-ExtraBold',
                    fontSize: width * (18 / 1920),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * (40 / 1920),
                      height: width * (40 / 1920),
                      child: Image.asset('assets/images/Handshake.png'),
                    ),
                    Text(
                      '40',
                      style: TextStyle(
                        color: getTextColor(themeProvider.isDarkMode),
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (40 / 1920),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

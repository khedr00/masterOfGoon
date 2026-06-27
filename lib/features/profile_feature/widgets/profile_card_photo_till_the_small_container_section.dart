import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class ProfileCardPhotoTillTheSmallContainerSection extends StatelessWidget {
  const ProfileCardPhotoTillTheSmallContainerSection({
    super.key,
    required this.employeePhoto,
    required this.productivity,
    required this.employeeEmail,
    required this.employeePhoneNumber,
    required this.employeeLocation,
    required this.avgResponseTime,
  });
  final String? employeePhoto;
  final String productivity;
  final String employeeEmail;
  final String employeePhoneNumber;
  final String employeeLocation;
  final String avgResponseTime;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: width * (735 / 1920),
      child: Center(
        child: Container(
          width: width * (371 / 1920),
          height: width * (695 / 1920),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * (5 / 1920)),
            color: themeProvider.isDarkMode
                ? darkSecondaryColor
                : secondaryColor,
          ),
          child: Column(
            children: [
              // اول قسم مع العرض كلو
              SizedBox(
                width: width * (371 / 1920),
                height: width * (339 / 1920),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * (250 / 1920),
                      child: Column(
                        children: [
                          SizedBox(
                            height: width * (200 / 1920),
                            child: Row(
                              children: [
                                //هون منحط الصورة الشخصية
                                SizedBox(
                                  width: width * (230 / 1920),
                                  child: SizedBox(
                                    width: width * (190 / 1920),
                                    height: width * (190 / 1920),
                                    child: employeePhoto == null
                                        ? Image.asset(
                                            'assets/images/profilePhoto-icon.png',
                                          )
                                        : Image.network(employeePhoto!),
                                  ),
                                ),
                                Container(
                                  width: width * (20 / 1920),
                                  decoration: BoxDecoration(
                                    color: themeProvider.isDarkMode
                                        ? darkBackGroundColor
                                        : backGroundColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // فيلر الأسم
                          Container(
                            height: width * (139 / 1920),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode
                                  ? darkBackGroundColor
                                  : backGroundColor,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(
                                  width * (10 / 1290),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * (121 / 1920),
                      child: Column(
                        children: [
                          // اول فيلر من فوق عاليمين
                          Container(
                            height: width * (185 / 1920),
                            color: themeProvider.isDarkMode
                                ? darkBackGroundColor
                                : backGroundColor,
                          ),
                          SizedBox(
                            height: width * (154 / 1920),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '$productivity%',
                                  style: TextStyle(
                                    color: getPrimaryTextColor(
                                      themeProvider.isDarkMode,
                                    ),
                                    fontFamily: 'NunitoSans-ExtraBold',
                                    fontSize: width * (40 / 1920),
                                  ),
                                ),
                                Text(
                                  'Productivity',
                                  style: TextStyle(
                                    color: getPrimaryTextColor(
                                      themeProvider.isDarkMode,
                                    ),
                                    fontFamily: 'NunitoSans-MediumItalic',
                                    fontSize: width * (16 / 1920),
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
              // تاني قسم قبل القسم التحتاني عالأخير
              SizedBox(
                width: width * (370 / 1920),
                height: width * (356 / 1920),
                child: Column(
                  children: [
                    SizedBox(
                      height: width * (249 / 1920),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: width * (60 / 1920),
                                height: width * (60 / 1920),
                                child: Image.asset(
                                  'assets/images/Address Book.png',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: width * (16 / 1920),
                                ),
                                child: Text(
                                  employeeEmail,
                                  style: TextStyle(
                                    color: getPrimaryTextColor(
                                      themeProvider.isDarkMode,
                                    ),
                                    fontFamily: 'NunitoSans-Bold',
                                    fontSize: width * (17 / 1920),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: width * (60 / 1920),
                                height: width * (60 / 1920),
                                child: Image.asset('assets/images/Phone.png'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: width * (28 / 1920),
                                ),
                                child: Text(
                                  employeePhoneNumber,
                                  style: TextStyle(
                                    color: getPrimaryTextColor(
                                      themeProvider.isDarkMode,
                                    ),
                                    fontFamily: 'NunitoSans-Bold',
                                    fontSize: width * (24 / 1920),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: width * (60 / 1920),
                                height: width * (60 / 1920),
                                child: Image.asset(
                                  'assets/images/Place Marker.png',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: width * (28 / 1920),
                                ),
                                child: Text(
                                  employeeLocation,
                                  style: TextStyle(
                                    color: getPrimaryTextColor(
                                      themeProvider.isDarkMode,
                                    ),
                                    fontFamily: 'NunitoSans-Bold',
                                    fontSize: width * (24 / 1920),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width * (107 / 1920),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * (145 / 1920),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Average response \n time',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: getPrimaryTextColor(
                                      themeProvider.isDarkMode,
                                    ),
                                    fontFamily: 'NunitoSans-Italic',
                                    fontSize: width * (16 / 1920),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: .spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: width * (40 / 1920),
                                      height: width * (40 / 1920),
                                      child: Image.asset(
                                        'assets/images/Stopwatch.png',
                                      ),
                                    ),
                                    Text(
                                      '$avgResponseTime minutes',
                                      style: TextStyle(
                                        color: getPrimaryTextColor(
                                          themeProvider.isDarkMode,
                                        ),
                                        fontFamily: 'NunitoSans-Bold',
                                        fontSize: width * (16 / 1920),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // تالت فيلر
                          Container(
                            width: width * (225 / 1920),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode
                                  ? darkBackGroundColor
                                  : backGroundColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(width * (10 / 1290)),
                              ),
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
      ),
    );
  }
}

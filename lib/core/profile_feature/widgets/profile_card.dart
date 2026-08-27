import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/get_employee_info/get_employee_info.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button.dart';
import 'package:untitled1/core/widgets/constants.dart';

import 'package:untitled1/providers/theme_provider.dart';
import 'package:untitled1/core/profile_feature/widgets/profile_card_photo_till_the_small_container_section.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key, required this.userAuthInfo, this.employeeId});
  final UserAuthInfo userAuthInfo;
  final String? employeeId;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  dynamic _employeeInfo;
  String? _loadError;
  final CancelToken _cancelToken = CancelToken();

  Future<void> _getMyInfo() async {
    try {
      final employeeInfo = await getEmployeeInfo(
        dioClient: DioClient(userAuthInfo: widget.userAuthInfo),
        cancelToken: _cancelToken,
        employeeId: widget.employeeId,
      );
      if (!mounted) return;
      setState(() => _employeeInfo = employeeInfo);
    } catch (error) {
      if (!mounted) return;
      setState(
        () => _loadError = error.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  @override
  void initState() {
    _getMyInfo();

    super.initState();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    if (_employeeInfo == null) {
      return Container(
        width: width * (411 / 1920),
        height: width * (950 / 1920),
        color: themeProvider.isDarkMode ? darkBackGroundColor : backGroundColor,
        child: _loadError == null
            ? Center(
                child: SizedBox(
                  width: width * (44 / 1920),
                  height: width * (44 / 1920),
                  child: const CircularProgressIndicator(strokeWidth: 3),
                ),
              )
            : Center(child: Text(_loadError!)),
      );
    }
    return Stack(
      children: [
        Container(
          width: width * (411 / 1920),
          height: width * (950 / 1920),
          color: themeProvider.isDarkMode
              ? darkBackGroundColor
              : backGroundColor,
          child: Column(
            children: [
              //اول قسم من فوق
              ProfileCardPhotoTillTheSmallContainerSection(
                employeePhoto: _employeeInfo.employeePhoto,
                productivity: _employeeInfo.productivity.toString(),
                employeeEmail: _employeeInfo.employeeEmail,
                employeePhoneNumber: _employeeInfo.employeePhoneNumber,
                employeeLocation: _employeeInfo.employeeLocation,
                avgResponseTime: _employeeInfo.avgResponseTime.toString(),
              ),
              // تاني شقفة صغيرة من تحت
              Container(
                width: width * (411 / 1920),
                height: width * (155 / 1920),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? darkSecondaryColor
                      : secondaryColor,
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
                  _employeeInfo.employeeType,
                  style: TextStyle(
                    color: getTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-ExtraBold',
                    fontSize: width * (20 / 1920),
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
                _employeeInfo.employeeName,
                style: TextStyle(
                  color: getTextColor(themeProvider.isDarkMode),
                  fontFamily: 'NunitoSans-ExtraBold',
                  fontSize: width * (22 / 1920),
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
        if (widget.employeeId?.isNotEmpty == true)
          Positioned(
            top: width * (355 / 1920),
            left: width * (16 / 1920),
            child: Tooltip(
              message: 'Copy employee ID',
              child: InkWell(
                borderRadius: BorderRadius.circular(width * (8 / 1920)),
                onTap: () async {
                  await Clipboard.setData(
                    ClipboardData(text: widget.employeeId!),
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Employee ID copied')),
                    );
                  }
                },
                child: Container(
                  width: width * (250 / 1920),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * (8 / 1920),
                    vertical: width * (6 / 1920),
                  ),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'ID: ${widget.employeeId}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: getPrimaryTextColor(
                              themeProvider.isDarkMode,
                            ),
                            fontFamily: 'NunitoSans-Medium',
                            fontSize: width * (14 / 1920),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.copy_outlined,
                        size: width * (18 / 1920),
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

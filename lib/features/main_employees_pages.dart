import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/header/main_employees_page_header.dart';

class MainEmployeesPages extends StatelessWidget {
  const MainEmployeesPages({
    super.key,
    required this.pageWidget,
    required this.userAuthInfo,
  });
  final Widget pageWidget;
  final UserAuthInfo userAuthInfo;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: MainEmployeesPageHeader(width: width, role: userAuthInfo.role),
      body: pageWidget,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/header/main_employees_page_header.dart';
import 'package:untitled1/features/employee_home_page.dart';
import 'package:untitled1/providers/main_employess_page_selector_provider.dart';

class MainEmployeesPages extends StatelessWidget {
  const MainEmployeesPages({
    super.key,
    // required this.pageWidget,
    required this.userAuthInfo,
  });
  // final Widget pageWidget;
  final UserAuthInfo userAuthInfo;

  @override
  Widget build(BuildContext context) {
    final mainEmployesspageSelectorProvider =
        Provider.of<MainEmployessPageSelectorProvider>(context);
    mainEmployesspageSelectorProvider.selectPage(
      EmployeeHomePage(userAuthInfo: userAuthInfo),
    );
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: MainEmployeesPageHeader(width: width, userAuthInfo: userAuthInfo),
      body: mainEmployesspageSelectorProvider.getPageSelected,
    );
  }
}

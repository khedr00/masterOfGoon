import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/header/main_employees_page_header.dart';
import 'package:untitled1/features/employee_home_page.dart';
import 'package:untitled1/providers/all_and_deals_only_provider.dart';
import 'package:untitled1/providers/icon_selector_provider.dart';
import 'package:untitled1/providers/main_employess_page_selector_provider.dart';
import 'package:untitled1/providers/submanager_page_selector_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return AllAndDealsOnlyProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return MainEmployessPageSelectorProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SubmanagerPageSelectorProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return IconSelectorProvider();
          },
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mainEmployesspageSelectorProvider =
        Provider.of<MainEmployessPageSelectorProvider>(context);
    mainEmployesspageSelectorProvider.selectPage(
      EmployeeHomePage(
        userAuthInfo: UserAuthInfo(
          id: 1,
          role: '',
          accessToken: '',
          refreshToken: '',
        ),
      ),
    );
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backGroundColor,
        appBar: MainEmployeesPageHeader(
          width: width,
          userAuthInfo: UserAuthInfo(
            id: 1,
            role: '',
            accessToken: '',
            refreshToken: '',
          ),
        ),
        body: mainEmployesspageSelectorProvider.getPageSelected,
        //   body:
        // // LoginPage()
      ),
    );
  }
}

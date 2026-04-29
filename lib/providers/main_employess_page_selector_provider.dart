import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/features/employee_home_page.dart';

class MainEmployessPageSelectorProvider extends ChangeNotifier {
  Widget pageSelected = EmployeeHomePage(
    userAuthInfo: UserAuthInfo(
      id: 1,
      role: 'role',
      accessToken: '',
      refreshToken: '',
    ),
  );
  Widget? get getPageSelected => pageSelected;

  // void setPage(Widget page) {
  //   pageSelected ??= page;
  //   notifyListeners();
  // }

  void selectPage(Widget page) {
    pageSelected = page;
    notifyListeners();
  }
}

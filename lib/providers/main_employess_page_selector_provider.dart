import 'package:flutter/material.dart';
import 'package:untitled1/features/employee_home_page.dart';

class MainEmployessPageSelectorProvider extends ChangeNotifier {
  Widget pageSelected = EmployeeHomePage();
  Widget get getPageSelected => pageSelected;

  void selectPage(Widget page) {
    if (pageSelected == page) {}
    pageSelected = page;
    notifyListeners();
  }
}

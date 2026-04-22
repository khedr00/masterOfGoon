import 'package:flutter/material.dart';
import 'package:untitled1/features/submanager/submanager_home_page.dart';

class SubmanagerPageSelectorProvider extends ChangeNotifier {
  Widget pageSelected = SubmanagerHomePage();
  Widget get getPageSelected => pageSelected;

  void selectPage(Widget page) {
    if (pageSelected == page) {}
    pageSelected = page;
    notifyListeners();
  }
}

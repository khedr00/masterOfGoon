import 'package:flutter/material.dart';

class GeneralmanagerPageSelectorProvider extends ChangeNotifier {
  Widget? pageSelected;
  Widget get getPageSelected => pageSelected!;

  void selectPage(Widget page) {
    pageSelected = page;
    notifyListeners();
  }
}

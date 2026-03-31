import 'package:flutter/material.dart';

class IconSelectorProvider extends ChangeNotifier {
  String iconSelected = 'assets/images/Parking.png';
  String get getPageSelected => iconSelected;
  String textSelected = '2 Cars';
  String get gettextSelected => textSelected;

  void selectIcon(String icon) {
    if (iconSelected == icon) {}
    iconSelected = icon;
    notifyListeners();
  }

  void selectText(String text) {
    if (textSelected == text) {}
    textSelected = text;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class NewAndOngoingDealsDbProvider extends ChangeNotifier {
  bool newAreClicked = true;
  bool get getNewAreClicked => newAreClicked;

  void falsingNewAreClicked() {
    newAreClicked = false;
    notifyListeners();
  }

  void truingNewAreClicked() {
    newAreClicked = true;
    notifyListeners();
  }
}

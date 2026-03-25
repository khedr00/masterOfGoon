import 'package:flutter/material.dart';

class AllAndDealsOnlyProvider extends ChangeNotifier {
  bool allAreClicked = true;
  bool get getAllAreClicked => allAreClicked;
  void falsingAllAreClicked() {
    allAreClicked = false;
    notifyListeners();
  }

  void truingAllAreClicked() {
    allAreClicked = true;
    notifyListeners();
  }
}

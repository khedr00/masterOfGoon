import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class TabOfTabableCard {
  TabOfTabableCard({
    required this.tabName,
    required this.tabColors,
    required this.bodyOfTheTab,
  });
  final String tabName;
  final ThemeColor tabColors;
  final Widget bodyOfTheTab;
}

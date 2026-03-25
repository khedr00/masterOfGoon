import 'package:flutter/material.dart';

class TabOfTabableCard {
  TabOfTabableCard({
    required this.tabName,
    required this.tabColor,
    required this.bodyOfTheTab,
  });
  final String tabName;
  final Color tabColor;
  final Widget bodyOfTheTab;
}

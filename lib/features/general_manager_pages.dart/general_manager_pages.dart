import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/general_manager_pages.dart/generalmanager_page_header.dart';
import 'package:untitled1/providers/generalmanager_page_selector_provider.dart';

class GeneralManagerPages extends StatelessWidget {
  const GeneralManagerPages({
    super.key,
    // required this.pageWidget,
    required this.userAuthInfo,
  });
  // final Widget pageWidget;
  final UserAuthInfo userAuthInfo;

  @override
  Widget build(BuildContext context) {
    final generalmanagerPageSelectorProvider =
        Provider.of<GeneralmanagerPageSelectorProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: GeneralmanagerPageHeader(
        width: width,
        userAuthInfo: userAuthInfo,
      ),
      body: generalmanagerPageSelectorProvider.getPageSelected,
    );
  }
}

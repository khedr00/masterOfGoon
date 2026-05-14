import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/submanager/submanager_page_header.dart';
import 'package:untitled1/providers/submanager_page_selector_provider.dart';

class SubmanagerPages extends StatelessWidget {
  const SubmanagerPages({
    super.key,
    // required this.pageWidget,
    required this.userAuthInfo,
  });
  // final Widget pageWidget;
  final UserAuthInfo userAuthInfo;

  @override
  Widget build(BuildContext context) {
    final submanagerPageSelectorProvider =
        Provider.of<SubmanagerPageSelectorProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: SubmanagerPageHeader(width: width, userAuthInfo: userAuthInfo),
      body: submanagerPageSelectorProvider.getPageSelected,
    );
  }
}

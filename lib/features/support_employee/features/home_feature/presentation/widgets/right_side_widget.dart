import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/body_live_chat_page.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/bottom_navigation_bar_for_live_chat_page.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/custom_Container_for_complaint.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/custom_app_bar_for_chat.dart';
import 'package:untitled1/providers/theme_provider.dart';

class RightSideWidget extends StatelessWidget {
  const RightSideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CustomAppBarForChat(),
        Container(
          width: width * 0.43,
          height: width * 0.47,
          decoration: BoxDecoration(
            color: getCardColor(themeProvider.isDarkMode),
            border: Border.all(width: width * 0.001, color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width * 0.02),
              bottomRight: Radius.circular(width * 0.02),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomContainerForComplaint(),
              SizedBox(height: width * 0.02),
              BodyLiveChatPage(),
              SizedBox(height: width * 0.02),
              BottomNavigationBarForLiveChatPage(),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/general_manager_pages.dart/lead_dashboard_page.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/submanager_dashbourd.dart';
import 'package:untitled1/providers/generalmanager_page_selector_provider.dart';
import 'package:untitled1/providers/theme_provider.dart';

class GeneralManagerDashboardPage extends StatelessWidget {
  const GeneralManagerDashboardPage({super.key, required this.userAuthInfo});

  final UserAuthInfo userAuthInfo;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Provider.of<ThemeProvider>(context);
    final pageSelector = Provider.of<GeneralmanagerPageSelectorProvider>(
      context,
      listen: false,
    );

    return Container(
      color: theme.isDarkMode ? darkBackGroundColor : backGroundColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              width * (40 / 1920),
              width * (16 / 1920),
              width * (40 / 1920),
              width * (8 / 1920),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.isDarkMode
                      ? darkPrimaryColor
                      : primaryColor,
                  foregroundColor: getTextColor(theme.isDarkMode),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * (22 / 1920),
                    vertical: width * (12 / 1920),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * (10 / 1920)),
                  ),
                ),
                onPressed: () {
                  pageSelector.selectPage(
                    LeadDashboardPage(
                      onBack: () {
                        pageSelector.selectPage(
                          GeneralManagerDashboardPage(
                            userAuthInfo: userAuthInfo,
                          ),
                        );
                      },
                    ),
                  );
                },
                icon: Icon(Icons.insights_rounded, size: width * (22 / 1920)),
                label: Text(
                  'Lead Dashboard',
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (16 / 1920),
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: SubmanagerDashbourd(userAuthInfo: userAuthInfo)),
        ],
      ),
    );
  }
}

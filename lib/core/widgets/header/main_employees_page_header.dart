import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_component.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_widget.dart';
import 'package:untitled1/core/widgets/header/internal_chat_button.dart';
import 'package:untitled1/features/employee_home_page.dart';
import 'package:untitled1/features/history_feature/screens/history_page.dart';
import 'package:untitled1/features/profile_feature/profile_page.dart';
import 'package:untitled1/features/property_feature/screen/property_page.dart';
import 'package:untitled1/features/schedule_feature/screen/schedule_page.dart';
import 'package:untitled1/providers/main_employess_page_selector_provider.dart';

class MainEmployeesPageHeader extends StatefulWidget
    implements PreferredSizeWidget {
  const MainEmployeesPageHeader({
    super.key,
    required this.width,
    required this.userAuthInfo,
  });
  final double width;
  final UserAuthInfo userAuthInfo;
  @override
  Size get preferredSize => Size.fromHeight(width * (119 / 1920));

  @override
  State<MainEmployeesPageHeader> createState() => _MainEmployeesPageHeader();
}

class _MainEmployeesPageHeader extends State<MainEmployeesPageHeader> {
  @override
  Widget build(BuildContext context) {
    final mainEmployesspageSelectorProvider =
        Provider.of<MainEmployessPageSelectorProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: width * (5 / 1920)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: width * (140 / 1920),
            height: width * (129 / 1920),
            child: Image.asset('assets/images/Estate_hub.png'),
          ),
          AppBarWidget(
            appBarComponents: [
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/profilePhoto-icon.png',
                appBarCopmonentName: 'Profile',
                onTap: () {
                  mainEmployesspageSelectorProvider.selectPage(
                    ProfilePage(userAuthInfo: widget.userAuthInfo),
                  );
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Home.png',
                appBarCopmonentName: 'Home',
                onTap: () {
                  mainEmployesspageSelectorProvider.selectPage(
                    EmployeeHomePage(userAuthInfo: widget.userAuthInfo),
                  );
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/notes-icon.png',
                appBarCopmonentName: 'Schedule',
                onTap: () {
                  mainEmployesspageSelectorProvider.selectPage(
                    SchedulePage(userAuthInfo: widget.userAuthInfo),
                  );
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/report-icon.png',
                appBarCopmonentName: 'Reports',
                onTap: () {},
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/history-icon.png',
                appBarCopmonentName: 'History',
                onTap: () {
                  mainEmployesspageSelectorProvider.selectPage(HistoryPage());
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Apartment.png',
                appBarCopmonentName: 'Properties',
                onTap: () {
                  mainEmployesspageSelectorProvider.selectPage(PropertyPage());
                },
              ),
            ],
          ),
          InternalChatButton(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_component.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_widget.dart';
import 'package:untitled1/core/widgets/header/internal_chat_button.dart';
import 'package:untitled1/features/property_feature/screen/property_page.dart';
import 'package:untitled1/features/submanager/employees_feature/employees_page.dart';
import 'package:untitled1/features/submanager/submanager_home_page.dart';
import 'package:untitled1/providers/submanager_page_selector_provider.dart';

class SubmanagerPageHeader extends StatefulWidget
    implements PreferredSizeWidget {
  const SubmanagerPageHeader({
    super.key,
    required this.width,
    required this.userAuthInfo,
  });
  final double width;
  final UserAuthInfo userAuthInfo;
  @override
  Size get preferredSize => Size.fromHeight(width * (119 / 1920));

  @override
  State<SubmanagerPageHeader> createState() => _SubmanagerPageHeader();
}

class _SubmanagerPageHeader extends State<SubmanagerPageHeader> {
  @override
  Widget build(BuildContext context) {
    final submanagerpageSelectorProvider =
        Provider.of<SubmanagerPageSelectorProvider>(context);
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
                onTap: () {},
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Home.png',
                appBarCopmonentName: 'Home',
                onTap: () {
                  submanagerpageSelectorProvider.selectPage(
                    SubmanagerHomePage(userAuthInfo: widget.userAuthInfo),
                  );
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Manager.png',
                appBarCopmonentName: 'Employs',
                onTap: () {
                  submanagerpageSelectorProvider.selectPage(EmployeesPage());
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Pie Chart.png',
                appBarCopmonentName: 'Dashbrd',
                onTap: () {},
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/report-icon.png',
                appBarCopmonentName: 'Reports',
                onTap: () {},
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Apartment.png',
                appBarCopmonentName: 'Properties',
                onTap: () {
                  submanagerpageSelectorProvider.selectPage(PropertyPage());
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

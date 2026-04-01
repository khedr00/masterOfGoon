import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_component.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_widget.dart';
import 'package:untitled1/core/widgets/header/internal_chat_button.dart';
import 'package:untitled1/features/employee_home_page.dart';
import 'package:untitled1/features/history_feature/screens/history_page.dart';
import 'package:untitled1/features/profile_feature/profile_page.dart';
import 'package:untitled1/features/property_feature/screen/property_page.dart';
import 'package:untitled1/features/schedule_feature/screen/schedule_page.dart';
import 'package:untitled1/providers/page_selector_provider.dart';

class PageHeader extends StatefulWidget implements PreferredSizeWidget {
  const PageHeader({super.key, required this.width});
  final double width;
  @override
  Size get preferredSize => Size.fromHeight(width * (119 / 1920));

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  @override
  Widget build(BuildContext context) {
    final pageSelectorProvider = Provider.of<PageSelectorProvider>(context);
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
                  pageSelectorProvider.selectPage(ProfilePage());
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Home.png',
                appBarCopmonentName: 'Home',
                onTap: () {
                  pageSelectorProvider.selectPage(EmployeeHomePage());
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/notes-icon.png',
                appBarCopmonentName: 'Schedule',
                onTap: () {
                  pageSelectorProvider.selectPage(SchedulePage());
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
                  pageSelectorProvider.selectPage(HistoryPage());
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Apartment.png',
                appBarCopmonentName: 'Properties',
                onTap: () {
                  pageSelectorProvider.selectPage(PropertyPage());
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

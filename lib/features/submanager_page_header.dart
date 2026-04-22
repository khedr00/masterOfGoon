import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_component.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_widget.dart';
import 'package:untitled1/core/widgets/header/internal_chat_button.dart';
import 'package:untitled1/features/profile_feature/profile_page.dart';
import 'package:untitled1/providers/submanager_page_selector_provider.dart';

class SubmanagerPageHeader extends StatefulWidget
    implements PreferredSizeWidget {
  const SubmanagerPageHeader({
    super.key,
    required this.width,
    required this.role,
  });
  final double width;
  final String role;
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
                onTap: () {
                  submanagerpageSelectorProvider.selectPage(ProfilePage());
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Home.png',
                appBarCopmonentName: 'Home',
                onTap: () {},
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/notes-icon.png',
                appBarCopmonentName: 'Schedule',
                onTap: () {},
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/report-icon.png',
                appBarCopmonentName: 'Reports',
                onTap: () {},
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/history-icon.png',
                appBarCopmonentName: 'History',
                onTap: () {},
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Apartment.png',
                appBarCopmonentName: 'Properties',
                onTap: () {},
              ),
            ],
          ),
          InternalChatButton(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_component.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_widget.dart';
import 'package:untitled1/core/widgets/header/internal_chat_button.dart';
import 'package:untitled1/features/general_manager_pages.dart/generalmanager_home_page.dart';
import 'package:untitled1/features/property_feature/screen/property_page.dart';
import 'package:untitled1/features/submanager/employees_feature/employees_page.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/submanager_dashbourd.dart';
import 'package:untitled1/providers/generalmanager_page_selector_provider.dart';

class GeneralmanagerPageHeader extends StatefulWidget
    implements PreferredSizeWidget {
  const GeneralmanagerPageHeader({
    super.key,
    required this.width,
    required this.userAuthInfo,
  });
  final double width;
  final UserAuthInfo userAuthInfo;
  @override
  Size get preferredSize => Size.fromHeight(width * (119 / 1920));

  @override
  State<GeneralmanagerPageHeader> createState() => _GeneralmanagerPageHeader();
}

class _GeneralmanagerPageHeader extends State<GeneralmanagerPageHeader> {
  @override
  Widget build(BuildContext context) {
    final generalmanagerPageSelectorProvider =
        Provider.of<GeneralmanagerPageSelectorProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: width * (5 / 1920)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * (80 / 1920),
                height: width * (80 / 1920),
                child: Image.asset('assets/images/profilePhoto-icon.png'),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * (20 / 1920)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yousef yaser',
                      style: TextStyle(
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (18 / 1920),
                      ),
                    ),
                    Text(
                      'yosef456@gmail.com',
                      style: TextStyle(
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (16 / 1920),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppBarWidget(
            appBarComponents: [
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Manager.png',
                appBarCopmonentName: 'Employs',
                onTap: () {
                  generalmanagerPageSelectorProvider.selectPage(
                    EmployeesPage(),
                  );
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Home.png',
                appBarCopmonentName: 'Home',
                onTap: () {
                  generalmanagerPageSelectorProvider.selectPage(
                    GeneralmanagerHomePage(),
                  );
                },
              ),

              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Pie Chart.png',
                appBarCopmonentName: 'Dashbrd',
                onTap: () {
                  generalmanagerPageSelectorProvider.selectPage(
                    SubmanagerDashbourd(),
                  );
                },
              ),
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Apartment.png',
                appBarCopmonentName: 'Properties',
                onTap: () {
                  generalmanagerPageSelectorProvider.selectPage(PropertyPage());
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

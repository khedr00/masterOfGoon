import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/a/chat/data/mock_data.dart';
import 'package:untitled1/a/chat/widgets/chat_dialog.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/contact_support_button/widgets/contact_support_button.dart';
import 'package:untitled1/core/widgets/floating_notification/floating_notification_card.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_component.dart';
import 'package:untitled1/core/widgets/header/app_bar/app_bar_widget.dart';
import 'package:untitled1/core/widgets/header/internal_chat_button.dart';
import 'package:untitled1/features/notification/modules/notification_model.dart';
import 'package:untitled1/features/notification/services/socket_service.dart';
import 'package:untitled1/features/property_feature/screen/property_page.dart';
import 'package:untitled1/features/submanager/employees_feature/employees_page.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/submanager_dashbourd.dart';
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
  NotificationModel? _notificationModel;

  SocketService socket = SocketService();
  Future<void> notificationTimeController() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      _notificationModel = null;
    });
  }

  @override
  void initState() {
    socket.connect(widget.userAuthInfo.id);

    socket.onNotification = (notification) {
      setState(() {
        _notificationModel = notification;
      });
      notificationTimeController();
    };
    super.initState();
  }

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
          ContactSupportButton(userAuthInfo: widget.userAuthInfo),
          AppBarWidget(
            appBarComponents: [
              AppBarComponentInfo(
                appBarComponentImage: 'assets/images/Manager.png',
                appBarCopmonentName: 'Employs',
                onTap: () {
                  submanagerpageSelectorProvider.selectPage(
                    EmployeesPage(userAuthInfo: widget.userAuthInfo),
                  );
                },
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
                appBarComponentImage: 'assets/images/Pie Chart.png',
                appBarCopmonentName: 'Dashbrd',
                onTap: () {
                  submanagerpageSelectorProvider.selectPage(
                    SubmanagerDashbourd(userAuthInfo: widget.userAuthInfo),
                  );
                },
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
          _notificationModel != null
              ? FloatingNotificationCard()
              : InternalChatButton(
                  onTap: () {
                    ChatDialog.show(context, UserType.salesManager);
                  },
                ),
        ],
      ),
    );
  }
}

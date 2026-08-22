import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/profile_feature/widgets/notification/notification_card.dart';
import 'package:untitled1/core/profile_feature/widgets/notification/notification_widget.dart';
import 'package:untitled1/core/profile_feature/widgets/profile_card.dart';
import 'package:untitled1/core/profile_feature/widgets/stats_widget.dart/stats_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ProfileCard(userAuthInfo: userAuthInfo),
          StatsWidget(),
          // SideNotificationWidget(userAuthInfo: userAuthInfo, wwidth: 800),
          NotificationWidget(
            personalNotes: [
              NotificationCard(
                notecolor: thirdColorSecondary,
                dangerIndicatorColor: sixthColorPrimaryRed,
                title: 'client MEETING',
                subTitle: 'ID : 3547859',
                date: '7/9/2025',
                description:
                    ' You have a metting with Ali Mostafa to check the  V -122  in Homs , Shien at   10/9/2025',
              ),
              NotificationCard(
                notecolor: thirdColorSecondary,
                dangerIndicatorColor: Color(0xffBBA30A),
                title: 'Unreported Deal',
                subTitle: 'ID : 3547859',
                date: '7/9/2025',
                description:
                    ' You closed the Kitlleman Villa Deal with Ali Mostafa on  V -122  in Homs , Shien at   10/9/2025 and you left it unreported .',
              ),
            ],
            wwidth: 800,
          ),
        ],
      ),
    );
  }
}

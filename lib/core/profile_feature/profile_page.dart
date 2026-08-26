import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/side_notification_widget.dart';
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
          SideNotificationWidget(userAuthInfo: userAuthInfo, wwidth: 800),
        ],
      ),
    );
  }
}

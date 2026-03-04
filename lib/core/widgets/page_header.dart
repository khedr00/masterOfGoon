import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/app_bar_component.dart';
import 'package:untitled1/core/widgets/app_bar_widget.dart';
import 'package:untitled1/core/widgets/internal_chat_button.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
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
            ),
            AppBarComponentInfo(
              appBarComponentImage: 'assets/images/Home.png',
              appBarCopmonentName: 'Home',
            ),
            AppBarComponentInfo(
              appBarComponentImage: 'assets/images/notes-icon.png',
              appBarCopmonentName: 'Schedule',
            ),
            AppBarComponentInfo(
              appBarComponentImage: 'assets/images/report-icon.png',
              appBarCopmonentName: 'Reports',
            ),
            AppBarComponentInfo(
              appBarComponentImage: 'assets/images/history-icon.png',
              appBarCopmonentName: 'History',
            ),
            AppBarComponentInfo(
              appBarComponentImage: 'assets/images/Apartment.png',
              appBarCopmonentName: 'Properties',
            ),
          ],
        ),
        InternalChatButton(),
      ],
    );
  }
}

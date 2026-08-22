import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/general_tabable_card/general_tabable_card.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';
import 'package:untitled1/core/profile_feature/widgets/notification/inside_personal_notification_widget.dart';
import 'package:untitled1/providers/theme_provider.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({
    super.key,

    required this.personalNotes,
    required this.wwidth,
  });

  final List<dynamic> personalNotes;
  final double wwidth;

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          width: width * (474 / 1920),
          child: GeneralTabableCard(
            tabs: [
              TabOfTabableCard(
                tabName: 'Notifications',
                tabColor: themeProvider.isDarkMode
                    ? darkThirdColorPrimary
                    : thirdColorPrimary,
                bodyOfTheTab: InsidePersonalNotificationWidget(
                  notesList: widget.personalNotes,
                ),
              ),
            ],
            fullCardWidth: width * (474 / 1920),
            fullCardHeight: width * (widget.wwidth / 1920),
          ),
        ),
        Positioned(
          right: width * (30 / 1920),
          child: Container(
            width: width * (45 / 1920),
            height: width * (45 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode
                  ? darkThirdColorPrimary
                  : thirdColorPrimary,
              borderRadius: BorderRadius.circular(width * (10 / 1920)),
            ),
            child: Image.asset('assets/images/Notification.png'),
          ),
        ),
      ],
    );
  }
}

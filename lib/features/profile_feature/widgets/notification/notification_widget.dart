import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/general_tabable_card/general_tabable_card.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';
import 'package:untitled1/features/profile_feature/widgets/notification/inside_personal_notification_widget.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({
    super.key,
    required this.managerNotes,
    required this.personalNotes,
  });
  final List<dynamic> managerNotes;
  final List<dynamic> personalNotes;

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          width: width * (474 / 1920),
          child: GeneralTabableCard(
            tabs: [
              TabOfTabableCard(
                tabName: 'Personal',
                tabColor: thirdColorPrimary,
                bodyOfTheTab: InsidePersonalNotificationWidget(
                  notesList: widget.personalNotes,
                ),
              ),
              TabOfTabableCard(
                tabName: 'Managers',
                tabColor: primaryColor,
                bodyOfTheTab: InsidePersonalNotificationWidget(
                  notesList: widget.managerNotes,
                ),
              ),
            ],
            fullCardWidth: width * (474 / 1920),
            fullCardHeight: width * (800 / 1920),
          ),
        ),
        Positioned(
          right: width * (30 / 1920),
          child: Container(
            width: width * (45 / 1920),
            height: width * (45 / 1920),
            decoration: BoxDecoration(
              color: thirdColorPrimary,
              borderRadius: BorderRadius.circular(width * (10 / 1920)),
            ),
            child: Image.asset('assets/images/Notification.png'),
          ),
        ),
      ],
    );
  }
}

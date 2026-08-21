import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/datasources/get_all_notifications.dart';
import 'package:untitled1/core/profile_feature/widgets/notification/notification_card.dart';
import 'package:untitled1/core/profile_feature/widgets/notification/notification_widget.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/notification/modules/notification_model.dart';

class SideNotificationWidget extends StatefulWidget {
  const SideNotificationWidget({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<SideNotificationWidget> createState() => _SideNotificationWidgetState();
}

class _SideNotificationWidgetState extends State<SideNotificationWidget> {
  // List<NotificationModel> _notificationModelList = [];
  final List<NotificationCard> _notificationCards = [];
  final CancelToken _cancelToken = CancelToken();
  void _getAllNotifications() async {
    DioClient dioClient = DioClient(userAuthInfo: widget.userAuthInfo);
    List<NotificationModel> notificationModelList = await getAllNotifications(
      dioClient: dioClient,
      cancelToken: _cancelToken,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      // _notificationModelList = notificationModelList;
      for (int i = 0; i < notificationModelList.length; i++) {
        _notificationCards.add(
          NotificationCard(
            notecolor: secondaryColor,
            dangerIndicatorColor: Colors.transparent,
            title: notificationModelList[i].title,
            subTitle: '',
            date: notificationModelList[i].createdAt,
            description: notificationModelList[i].body,
          ),
        );
      }
      // if (employeeCardsInfoList.isNotEmpty) {
      //   _falsingcardIsClicked();
      //   _cardIsClicked[0] = true;
      //   _employeeId = _employeeCardInfoList[0].employeeId;
      // } else {}
    });
  }

  @override
  void initState() {
    _getAllNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationWidget(personalNotes: _notificationCards);
  }
}

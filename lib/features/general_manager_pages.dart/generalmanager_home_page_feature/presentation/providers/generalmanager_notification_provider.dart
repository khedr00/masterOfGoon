import 'package:flutter/material.dart';
import 'package:untitled1/core/profile_feature/widgets/notification/notification_card.dart';

class GeneralmanagerNotificationProvider extends ChangeNotifier {
  List<NotificationCard> notifications = [];
  List<NotificationCard> get getNotifications => notifications;

  void addNotification(NotificationCard notification) {
    notifyListeners();
  }
}

import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('iconsnotification64');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void selectNotification(String? payload) {}

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}
  Future<void> showNotification(String? title, String? body) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Simple Notification',
            body: 'Simple body'),
        actionButtons: [
          NotificationActionButton(
            label: 'Yes',
            enabled: true,
            buttonType: ActionButtonType.Default,
            key: 'yes',
          ),
          NotificationActionButton(
            label: 'No',
            enabled: true,
            buttonType: ActionButtonType.Default,
            key: 'no',
          )
        ]);
  }
}

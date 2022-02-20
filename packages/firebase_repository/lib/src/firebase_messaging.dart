import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_repository/src/firebase_config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'message.dart';
import 'message_list.dart';
import 'permissions.dart';
import 'token_monitor.dart';

class FirebaseMessagingService {
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp(
        options: DefaultFirebaseConfig.platformOptions);
   
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseConfig.platformOptions);

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title // description
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    AwesomeNotifications().initialize(
  // set the icon to null if you want to use the default app icon
  null,
  [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Color.fromARGB(255, 255, 0, 255)),
        
  ],
  // Channel groups are only visual and are not required
  channelGroups: [
    NotificationChannelGroup(
        channelGroupkey: 'basic_channel_group',
        channelGroupName: 'Basic group')
  ],
  debug: true
);
AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  if (!isAllowed) {
    // This is just a basic example. For real apps, you must show some
    // friendly dialog box before call the request method.
    // This is very important to not harm the user experience
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
});
     listenToMessages();
  }

  /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
  String constructFCMPayload(String? token) {
    return jsonEncode({
      'token': token??"",
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification  was created via FCM!',
      },
    });
  }

  Future<String?>  getToken() async {

   var _firebaseMessaging =  FirebaseMessaging.instance;
  final deviceToken = await  _firebaseMessaging.getToken();
  return deviceToken;

  }

  void listenToMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
       AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: Random().nextInt(328479),
            channelKey: 'basic_channel',
            title: notification.title,
            body: notification.body),
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
    });

    FirebaseMessaging.onMessageOpenedApp.listen(( message) {
       print('message received!');
      print(message.toString());
    });

    AwesomeNotifications().actionStream.listen(
    ( event){
      print('event received!');
      print(event.toMap().toString());
    }
);
  }


  Future<void> sendPushMessage() async {

  }

  Future<void> onActionSelected(String value) async {
    
  }
}


// import 'dart:ui';

// import 'package:awesome_notifications/awesome_notifications.dart';


// class AwsomeNotficationServ {
//   Future<void> init() async {
//     AwesomeNotifications().initialize(
//         // set the icon to null if you want to use the default app icon
//         'resource://drawable/res_app_icon',
//         [
//           NotificationChannel(
//               channelGroupKey: 'basic_channel_group',
//               channelKey: 'basic_channel',
//               channelName: 'Basic notifications',
//               channelDescription: 'Notification channel for basic tests',
//               defaultColor: Color(0xFF9D50DD),
//               ledColor: Color.fromARGB(255, 255, 0, 255))
//         ],
//         // Channel groups are only visual and are not required
//         channelGroups: [
//           NotificationChannelGroup(
//               channelGroupkey: 'basic_channel_group',
//               channelGroupName: 'Basic group')
//         ],
//         debug: true);
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         // This is just a basic example. For real apps, you must show some
//         // friendly dialog box before call the request method.
//         // This is very important to not harm the user experience
//         // AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//     listenToMessages();
//   }

//   void listenToMessages() {
//     AwesomeNotifications()
//         .actionStream
//         .listen((ReceivedNotification receivedNotification) {});
//   }

//   Future<void> showNotification(String? title,String? body ) async { 

//   }
// }

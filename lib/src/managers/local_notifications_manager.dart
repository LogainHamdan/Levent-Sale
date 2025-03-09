// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:sellha/src/config/constants.dart';
//
// class LocalNotificationsManager {
//   static LocalNotificationsManager? _instance;
//   late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   int _id = 0;
//
//   // private constructor.
//   LocalNotificationsManager._();
//
//   // singleton pattern.
//   static LocalNotificationsManager get instance =>
//       _instance ?? (_instance = LocalNotificationsManager._());
//
//   // init.
//   Future<void> init() async {
//     AndroidInitializationSettings androidInitializationSettings =
//         // const AndroidInitializationSettings('@mipmap/launcher_icon');
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//     DarwinInitializationSettings iosInitializationSettings =
//         DarwinInitializationSettings(
//             onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
//     InitializationSettings initializationSettings = InitializationSettings(
//         android: androidInitializationSettings, iOS: iosInitializationSettings);
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       // onSelectNotification: onNotificationTapped
//     );
//   }
//
//   // on did received local notification.
//   void _onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//
//   }
//
//   // on notification tapped.
//   Future onNotificationTapped(String? payload) async {
//     debugPrint('starting [onNotificationTapped][LocalNotificationsService]...');
//     debugPrint('payload : $payload');
//
//   }
//
//   // show notification.
//   void showNotification(
//     String? title,
//     String? message, {
//     String? payload,
//   }) {
//     _flutterLocalNotificationsPlugin.show(
//       ++_id,
//       title,
//       message,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           Constants.androidNotificationChannelId,
//           Constants.androidNotificationChannelName,
//           enableVibration: true,
//           importance: Importance.max,
//           priority: Priority.max,
//         ),
//         iOS: DarwinNotificationDetails(),
//       ),
//       payload: payload,
//     );
//   }
// }

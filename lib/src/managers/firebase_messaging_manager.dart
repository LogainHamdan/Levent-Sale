import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'local_notifications_manager.dart';

class FirebaseMessagingManager {
  static FirebaseMessagingManager? _instance;
  late final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late final LocalNotificationsManager _localNotificationsManager =
      LocalNotificationsManager.instance;

  // private constructor.
  FirebaseMessagingManager._();

  // singleton pattern.
  static FirebaseMessagingManager get instance {
    if (_instance != null) return _instance!;
    return _instance = FirebaseMessagingManager._();
  }

  // get token.
  Future<String?> getToken() async {
    return await _fcm.getToken();
  }

  // init.
  Future<void> init() async {
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('device token : ${await getToken()}');
    FirebaseMessaging.onMessage.listen(
      (message) {
        // on message.
        debugPrint('starting [onMessage][FirebaseMessagingService]...');
        RemoteNotification? notification = message.notification;
        debugPrint(notification?.title);
        debugPrint(notification?.body);
        debugPrint(message.data.toString());
        String? chatId = message.data['chat_id'];
        if (notification != null) {
          if (chatId == null) {
            _localNotificationsManager.showNotification(
              notification.title,
              notification.body,
              payload: jsonEncode(
                message.toMap(),
              ),
            );
          } else {

          }
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        // on message opened app.
        debugPrint(
            'starting [onMessageOpenedApp][FirebaseMessagingService]...');
        RemoteNotification? notification = message.notification;
        debugPrint(notification?.title);
        debugPrint(notification?.body);
        debugPrint(message.data.toString());
        _localNotificationsManager
            .onNotificationTapped(jsonEncode(message.toMap()));
      },
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // after opening notification when app is terminated.

  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // on background message.
  debugPrint('starting [onBackgroundMessage][FirebaseMessagingService]...');
  RemoteNotification? notification = message.notification;
  debugPrint(notification?.title);
  debugPrint(notification?.body);
  debugPrint(message.data.toString());
}

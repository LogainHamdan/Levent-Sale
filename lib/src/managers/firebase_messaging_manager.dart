import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'local_notifications_manager.dart';

class FirebaseMessagingManager {
  static FirebaseMessagingManager? _instance;
  late final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late final LocalNotificationsManager _localNotificationsManager =
      LocalNotificationsManager.instance;

  FirebaseMessagingManager._();

  static FirebaseMessagingManager get instance {
    return _instance ??= FirebaseMessagingManager._();
  }

  Future<String?> getToken() async {
    final token = await _fcm.getToken();
    debugPrint('📱 FCM Token: $token');
    return token;
  }

  Future<void> init() async {
    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint("❌ Notification permission denied by user.");
      return;
    }

    await getToken();

    // 🔔 on foreground message
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('📩 onMessage received');
      final notification = message.notification;
      final chatId = message.data['chat_id'];
      if (notification != null && chatId == null) {
        _localNotificationsManager.showNotification(
          notification.title,
          notification.body,
          payload: jsonEncode(message.toMap()),
        );
      }
    });

    // 🚀 on message opened (app in background then opened by tap)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('🚀 onMessageOpenedApp triggered');
      _localNotificationsManager
          .onNotificationTapped(jsonEncode(message.toMap()));
    });

    // ❗ on background message
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 💤 when app opened from terminated state by notification
    final initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      debugPrint("🪪 App launched via notification.");
      _localNotificationsManager
          .onNotificationTapped(jsonEncode(initialMessage.toMap()));
    }
  }
}

// background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('📤 onBackgroundMessage received');
  final notification = message.notification;
  if (notification != null) {
    await LocalNotificationsManager.instance.showNotification(
      notification.title,
      notification.body,
      payload: jsonEncode(message.toMap()),
    );
  }
}

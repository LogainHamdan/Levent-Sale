import 'dart:io';

import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/models/notifications.dart';
import 'package:Levant_Sale/src/modules/home/repos/evaluation.dart';
import 'package:Levant_Sale/src/modules/home/repos/evaluation.dart';
import 'package:Levant_Sale/src/modules/home/repos/notifications.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../models/rating.dart';

import 'package:flutter/material.dart';
import 'package:Levant_Sale/src/modules/home/models/notifications.dart';
import 'package:Levant_Sale/src/modules/home/repos/notifications.dart';

import '../../../models/stats-notification.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepository _repo = NotificationRepository();

  bool isLoading = false;
  NotificationStats? _notificationStats;
  bool _allRead = false;
  List<NotificationItem> _notifications = [];
  NotificationItem? _selectedNotification;
  List<NotificationItem> get notifications => _notifications;

  NotificationStats? get notificationStats => _notificationStats;
  NotificationItem? get selectedNotification => _selectedNotification;

  bool get allRead => _allRead;

  set allRead(bool value) {
    _allRead = value;
    notifyListeners();
  }

  set selectedNotification(NotificationItem? value) {
    _selectedNotification = value;
    notifyListeners();
  }

  Future<void> getNotifications({
    required String token,
    required int recipientId,
    bool? isRead,
    String? type,
    int? page,
    int? size,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final notifications = await _repo.getNotifications(
          token: token,
          recipientId: recipientId,
          isRead: isRead,
          type: type,
          page: page,
          size: size);

      if (notifications != null) {
        _notifications = notifications;
        print('notifications fetched successfully: $_notifications');
      }
    } catch (e) {
      print('Error getting notifications: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getNotificationStats({
    required String token,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final stats = await _repo.getStatsNotifications(token: token);
      _notificationStats = stats;
      print('notification stats fetched successfully: $_notificationStats');
    } catch (e) {
      print('Error getting notification stats: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markRead({
    required String token,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      await _repo.markRead(
          token: token, notificationId: _selectedNotification?.id ?? '');
      _selectedNotification?.read = true;
      print('marked read successfully: ${_selectedNotification?.id ?? ''}');
      notifyListeners();
    } catch (e) {
      print('Error marking read: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAllRead() async {
    try {
      isLoading = true;
      notifyListeners();

      final token = await TokenHelper.getToken();
      final user = await UserHelper.getUser();

      await _repo.markAllRead(
        recipientId: '${user?.id ?? 0}',
        token: token ?? '',
      );

      for (var notif in _notifications) {
        notif.read = true;
      }

      _allRead = true;
      notifyListeners();
      print('marked all read successfully');
    } catch (e) {
      print('Error marking all read: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteNotification() async {
    try {
      isLoading = true;
      notifyListeners();

      final token = await TokenHelper.getToken();
      final String notificationId = _selectedNotification?.id ?? '';

      await _repo.deleteNotification(
        notificationId: notificationId,
        token: token ?? '',
      );

      _notifications.removeWhere((notif) => notif.id == notificationId);
      _selectedNotification = null;

      notifyListeners();
      print('notification deleted successfully');
    } catch (e) {
      print('Error notification delete: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(date);
  }
}

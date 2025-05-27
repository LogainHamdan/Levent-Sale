import 'package:Levant_Sale/src/modules/home/models/notifications.dart';
import 'package:dio/dio.dart';

import '../../../config/constants.dart';
import '../models/rating.dart';
import '../models/stats-notification.dart';

class NotificationRepository {
  static final NotificationRepository _instance =
      NotificationRepository._internal();

  factory NotificationRepository() => _instance;

  NotificationRepository._internal();

  final Dio _dio = Dio();

  Future<List<NotificationItem>?> getNotifications({
    required String token,
    required int recipientId,
    bool? isRead,
    String? type,
    int? page = 0,
    int? size = 10,
  }) async {
    try {
      final response = await _dio.get(
        '$getNotificationsUrl/$recipientId',
        queryParameters: {
          if (isRead != null) 'isRead': isRead,
          if (type != null) 'type': type,
          if (page != null) 'page': page,
          if (size != null) 'size': size,
        },
        options: Options(
          headers: {
            'Authorization': token,
            'Accept': '*/*',
          },
        ),
      );

      final data = response.data;

      final List<dynamic> notificationsJson = data['content'] ?? [];

      return notificationsJson
          .map((json) => NotificationItem.fromJson(json))
          .toList();
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
          'Notifications fetch failed: ${e.response?.statusCode} ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<NotificationStats> getStatsNotifications({
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        getStatsNotificationUrl,
        options: Options(
          headers: {
            'Authorization': token,
            'Accept': '*/*',
          },
        ),
      );

      final data = response.data;

      final json = data['data'] ?? data;

      return NotificationStats.fromJson(json);
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
        'stats fetch failed: ${e.response?.statusCode} ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Response> markRead({
    required String token,
    required String notificationId,
  }) async {
    try {
      final response = await _dio.post(
        '$markReadUrl/$notificationId',
        options: Options(
          headers: {
            'Authorization': token,
            'Accept': '*/*',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
        'mark read failed: ${e.response?.statusCode} ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Response> markAllRead({
    required String token,
    required String recipientId,
  }) async {
    try {
      final response = await _dio.post(
        '$markAllReadUrl/$recipientId',
        options: Options(
          headers: {
            'Authorization': token,
            'Accept': '*/*',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
        'mark read failed: ${e.response?.statusCode} ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Response> deleteNotification({
    required String token,
    required String notificationId,
  }) async {
    try {
      final response = await _dio.delete(
        '$deleteNotfUrl/$notificationId',
        options: Options(
          headers: {
            'Authorization': token,
            'Accept': '*/*',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
        'mark read failed: ${e.response?.statusCode} ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

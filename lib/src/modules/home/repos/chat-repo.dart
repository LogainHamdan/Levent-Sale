import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../config/constants.dart';
import '../models/chats.dart';
import '../models/conversation.dart';

class ChatRepository {
  static final ChatRepository _instance = ChatRepository._internal();

  factory ChatRepository() => _instance;

  ChatRepository._internal();

  final Dio _dio = Dio();

  Future<ChatMessageResponse> getConversation({
    required String token,
    required int senderId,
    required int receiverId,
    required int adId,
    required int page,
    required int limit,
  }) async {
    try {
      print('Query parameters sent: ${{
        'token': token,
        'senderId': senderId,
        'receiverId': receiverId,
        'adId': adId,
        'page': page,
        'limit': limit,
      }}');

      final response = await _dio.get(
        '$getConversationUrl?senderId=$senderId&receiverId=$receiverId&adId=$adId&page=$page&limit=$limit',
        options: Options(headers: {'Authorization': token}),
      );
      print('conversation loaded successfully: ${response.data}');

      return ChatMessageResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
          'Getting the chat failed: ${e.response?.statusCode} ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<ConversationListResponse> getChats({
    required String token,
    required int userId,
  }) async {
    try {
      print('Query parameters sent: { token: $token, userId: $userId }');

      final response = await _dio.get(
        '$getChatsUrl/$userId',
        options: Options(headers: {
          'Authorization': token,
          'Content-Type': 'application/json'
        }),
      );

      print(response.data);

      return ConversationListResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
          'Getting the conversation failed: ${e.response?.statusCode} ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<bool> markAsRead({
    required String token,
    required String firstMsgId,
    required String secondMsgId,
    required String thirdMsgId,
  }) async {
    try {
      print(
          'parameters sent: { firstMsgId: $firstMsgId, secondMsgId: $secondMsgId, thirdMsgId: $thirdMsgId }');
      final response = await _dio.put(markAsReadUrl,
          options: Options(
            headers: {
              'Authorization': token,
              'Content-Type': 'application/json'
            },
          ),
          queryParameters: {
            'first msg id': firstMsgId,
            'second msg id': secondMsgId,
            'third msg id': thirdMsgId,
          });

      print(response.data);

      return true;
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
          'mark as read failed: ${e.response?.statusCode} ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:dio/dio.dart';
import '../models/faqQuestion.dart';

import '../models/ticket-msg.dart';
import '../models/ticket-msgDTO.dart';
import '../models/ticket.dart';

class TechSupportRepository {
  static final TechSupportRepository _instance =
      TechSupportRepository._internal();

  final Dio _dio = Dio();

  TechSupportRepository._internal();

  factory TechSupportRepository() => _instance;
  Future<List<FAQuestion>> getFAQ() async {
    try {
      final response = await _dio.get(
        getFQAUrl,
        options: Options(
          headers: {
            'Accept': '*/*',
          },
        ),
      );

      final List<dynamic> data = response.data;
      return data.map((faq) => FAQuestion.fromJson(faq)).toList();
    } on DioException catch (e) {
      print('Error fetching FAQs: ${e.response?.statusCode} ${e.message}');
      throw Exception('Failed to fetch FAQs');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  Future<String>? getAnswerFAQ({required String id}) async {
    try {
      final response = await _dio.get(
        '$getAnswerUrl/$id',
        options: Options(
          headers: {
            'Accept': '*/*',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      print('Error fetching answer: ${e.response?.statusCode} ${e.message}');
      throw Exception('Failed to fetch answer');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  Future<Response> addTicket({
    required String token,
    required TicketMessageDTO ticket,
  }) async {
    try {
      final response = await _dio.post(
        addTicketUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: ticket.toJson(),
      );
      return response;
    } on DioException catch (e) {
      print('Error creating ticket: ${e.response?.statusCode} ${e.message}');
      throw Exception('Failed to create ticket');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  Future<List<Ticket>?> getTickets({
    required String token,
    required int userId,
  }) async {
    try {
      final response = await _dio.get(
        '$getTicketsUrl/$userId',
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': token,
          },
        ),
      );

      final data = response.data;
      if (data == null) {
        throw Exception('No data received from server');
      }

      if (data is! List) {
        throw Exception('Expected list but got ${data.runtimeType}');
      }

      return data.map<Ticket>((ticketJson) {
        final ticket = Ticket.fromJson(ticketJson);
        print('ticket: ${ticket.id}');

        return ticket;
      }).toList();
    } on DioException catch (e) {
      print('Error fetching tickets: ${e.response?.statusCode} ${e.message}');
      throw Exception('Failed to fetch tickets: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to process tickets: $e');
    }
  }

  Future<List<TicketMessage>?> getTicketMessages({
    required String token,
    required String ticketId,
  }) async {
    try {
      final response = await _dio.get(
        '$getTicketMsgsUrl/$ticketId',
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': token,
          },
        ),
      );

      if (response.data is List) {
        final data = response.data as List;
        return data.map((json) => TicketMessage.fromJson(json)).toList();
      } else {
        print('Unexpected response format: ${response.data}');
        return [];
      }
    } on DioException catch (e) {
      print('Error fetching messages: ${e.response?.statusCode} ${e.message}');
      return [];
    } catch (e) {
      print('Unexpected error: $e');
      return [];
    }
  }

  Future<TicketMessage> replyTicket(
    String message, {
    required String token,
    required String ticketId,
  }) async {
    try {
      final response = await _dio.post(
        '$replyTicketUrl/$ticketId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': token,
          },
        ),
        data: message,
      );
      print('replies successfully: ${response.data}');
      if (response.data is Map<String, dynamic>) {
        return TicketMessage.fromJson(response.data);
      } else {
        print('Unexpected response format: ${response.data}');
        throw Exception('Invalid response format');
      }
    } on DioException catch (e) {
      print('Error sending reply: ${e.response?.statusCode} ${e.message}');
      throw Exception('Failed to send reply: ${e.response?.statusCode}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}

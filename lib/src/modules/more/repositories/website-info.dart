import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:dio/dio.dart';
import '../models/faqQuestion.dart';

import '../models/ticket-msg.dart';
import '../models/ticket-msgDTO.dart';
import '../models/ticket.dart';

class WebsiteInfoRepository {
  static final WebsiteInfoRepository _instance =
      WebsiteInfoRepository._internal();

  final Dio _dio = Dio();

  WebsiteInfoRepository._internal();

  factory WebsiteInfoRepository() => _instance;
  Future<String> getAboutUs() async {
    try {
      final response = await _dio.get(getAboutUsUrl);
      print(response.data['content']);
      return response.data['content'];
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  Future<String> getTerms() async {
    try {
      final response = await _dio.get(
        getTermsUrl,
        options: Options(
          headers: {
            'Accept': '*/*',
          },
        ),
      );
      print(response.data['content']);

      return response.data['content'];
    } on DioException catch (e) {
      print('Error fetching terms: ${e.response?.statusCode} ${e.message}');
      throw Exception('Failed to fetch terms');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  Future<String> getPrivacyPolicy() async {
    try {
      final response = await _dio.get(
        getPolicyUrl,
        options: Options(
          headers: {
            'Accept': '*/*',
          },
        ),
      );
      print(response.data['content']);
      return response.data['content'];
    } on DioException catch (e) {
      print('Error fetching policy: ${e.response?.statusCode} ${e.message}');
      throw Exception('Failed to fetch policy');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error occurred');
    }
  }
}

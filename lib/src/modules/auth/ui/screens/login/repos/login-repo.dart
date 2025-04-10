import 'dart:convert';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  final Dio dio;

  LoginRepository({required this.dio});

  Future<Map<String, dynamic>> loginUser({
    required String identifier,
    required String password,
    required String recaptchaToken,
  }) async {
    try {
      final response = await dio.post(
        loginUrl,
        data: {
          'identifier': identifier,
          'password': password,
          'recaptchaToken': recaptchaToken,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/hab/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data['token']);
        await prefs.setString('userData', jsonEncode(response.data['user']));
        return {'success': true, 'data': response.data};
      }
      return {
        'success': false,
        'error': response.data['message'] ?? 'Invalid credentials'
      };
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'فشل تسجيل الدخول: ${e.message}',
      );
    }
  }
}

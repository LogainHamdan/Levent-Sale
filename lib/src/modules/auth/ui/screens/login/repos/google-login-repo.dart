import 'dart:convert';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleLoginRepository {
  final Dio dio;

  GoogleLoginRepository({required this.dio});

  Future<Map<String, dynamic>> googleLogin(String token) async {
    try {
      final response = await dio.post(
        googleLoginUrl,
        data: {'token': token},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
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
        'error': response.data['message'] ?? 'Google login failed'
      };
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to login with Google',
        );
      } else {
        throw Exception('Failed to login with Google: ${e.message}');
      }
    }
  }
}

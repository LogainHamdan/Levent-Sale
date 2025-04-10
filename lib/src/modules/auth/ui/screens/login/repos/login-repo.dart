import 'dart:convert';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';

import 'package:dio/dio.dart';
import 'package:Levant_Sale/src/config/constants.dart';

class LoginRepository {
  static final LoginRepository _instance = LoginRepository._internal();

  LoginRepository._internal();

  factory LoginRepository() {
    return _instance;
  }

  final Dio dio = Dio();

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
          headers: {'Content-Type': 'application/json'},
        ),
      );

      return {'statusCode': response.statusCode, 'data': response.data};
    } on DioException catch (e) {
      return {
        'error': e.response?.data['message'] ?? 'Login failed: ${e.message}'
      };
    }
  }
}

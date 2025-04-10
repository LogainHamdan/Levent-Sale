import 'dart:convert';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Levant_Sale/src/config/constants.dart';

class GoogleLoginRepository {
  final Dio dio;

  GoogleLoginRepository({Dio? dio}) : dio = dio ?? Dio();

  Future<Map<String, dynamic>> googleLogin(String token) async {
    try {
      final response = await dio.post(
        googleLoginUrl,
        data: {'token': token},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      return response.data;
    } on DioException catch (e) {
      return {
        'error': e.response?.data['message'] ??
            'Failed to login with Google: ${e.message}'
      };
    }
  }
}

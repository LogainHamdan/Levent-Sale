import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/constants.dart';
import '../models/business-owner-model.dart';
import '../models/personal-model.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();

  late final Dio dio;

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<Response> signUpBusinessOwner(BusinessOwner owner) async {
    return await dio.post(
      signUpBusinessOwnerUrl,
      data: owner.toJson(),
    );
  }

  Future<Response> signUpPersonalAccount(PersonalModel account) async {
    return await dio.post(
      signUpUrl,
      data: account.toJson(),
    );
  }

  Future<Response> requestPasswordReset(String email) async {
    final String url = '$requestUpdatePassUrl/$email';

    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/hal+json",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) return e.response!;
      rethrow;
    }
  }

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

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('User not logged in');

    try {
      await dio.post(
        logoutUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      await prefs.clear();
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Logout failed: ${e.message}');
    }
  }

  Future<Response> verifyToken(String token) async {
    try {
      final response = await dio.get(
        verifyUrl,
        queryParameters: {'token': token},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> resendVerificationCode(String email) async {
    return await dio.get('$resendVerifyUrl/$email');
  }
}

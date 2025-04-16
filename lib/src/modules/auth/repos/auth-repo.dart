import 'dart:convert';

import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
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
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        logPrint: (object) => print('DIO LOG: $object'),
      ),
    );
  }

  Future<Response> signUpBusinessOwner(BusinessOwner owner) async {
    return await dio.post(signUpBusinessOwnerUrl, data: owner.toJson());
  }

  Future<Response> signUpPersonalAccount(PersonalModel account) async {
    return await dio.post(signUpUrl, data: account.toJson());
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
        data: jsonEncode({'token': token}),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return {'statusCode': 200};
      } else {
        return {
          'error':
              'Google login failed with status code: ${response.statusCode}'
        };
      }
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
  }) async {
    try {
      print("Login request: $identifier, $password");

      final response = await dio.post(
        loginUrl,
        data: {
          'identifier': identifier,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/hal+json',
          },
        ),
      );

      print("Login response data: ${response.data}");
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } on DioException catch (e) {
      print("Login DioException:");
      print("Message: ${e.message}");
      print("Type: ${e.type}");
      print("Response: ${e.response?.data}");

      return {
        'error': e.response?.data['message'] ??
            'خطأ غير معروف: تأكد من الاتصال بالإنترنت.',
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
    dio.options.headers['Authorization'] = 'Bearer $token';

    return await dio.post(
      verifyUrl,
      data: {'token': token},
    );
  }

  Future<Response> resendVerificationCode(String email) async {
    return await dio.post(
      '$resendVerifyUrl/$email',
      data: {'email': email},
    );
  }

  Future<void> setupAuthHeaderFromStorage() async {
    final token = await TokenHelper.getToken();
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}

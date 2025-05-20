import 'dart:convert';

import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/constants.dart';
import '../models/user.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();

  late final Dio dio;

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal() {
    dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<Response> signUp(User owner) async {
    return await dio.post(signUpUrl, data: owner.toJson());
  }

  Future<Response> requestPasswordReset({required String email}) async {
    final String url = '$requestUpdatePassUrl/$email';
    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            "Accept": "application/hal+json",
          },
          responseType: ResponseType.plain,
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      return response;
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response: ${e.response?.data}');
      return e.response ??
          Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 500,
            statusMessage: 'Unknown Error',
          );
    }
  }

  Future<Response> googleLogin(String token) async {
    try {
      final response = await dio.post(
          googleLoginUrl,
          data: jsonEncode({'token': token}),
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/hal+json',
          }));
          print('Response data: ${response.data}');
      return response;
    } on DioException catch (e) {
      print('DioException occurred: ${e.error}');
      print('DioException occurred: ${e.response?.statusCode}');
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      print('Unexpected error occurred: ${e.toString()}');
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  Future<User?> getUserById({required int id}) async {
    try {
      final response = await dio.get(
        'http://37.148.208.169:8081/users/$id',
        options: Options(
          headers: {
            'Accept': 'application/hal+json',
          },
        ),
      );
      print(response.data);
      return User.fromJson(response.data);
    } on DioException catch (e) {
      print("Error: ${e.message}");
      print("Error: ${e.response?.statusCode}");
      print("Error: ${e.type}");
      print("Raw response: ${e.response?.data}");
      return null;
    }
  }

  Future<Response> logoutUser({required String token}) async {
    print('token: $token');

    try {
      final response = await dio.post(
        logoutUrl,
        options: Options(
          headers: {
            'Authorization': token,
            'Accept': 'application/hal+json',
          },
        ),
      );

      await TokenHelper.removeToken();
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
        throw Exception(e.response?.data ?? 'حدث خطأ أثناء تسجيل الخروج');
      } else {
        throw Exception('تعذر الاتصال بالخادم: ${e.message}');
      }
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

  Future<Map<String, dynamic>> loginUser({
    required String identifier,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        loginUrl,
        data: jsonEncode({
          'identifier': identifier,
          'password': password,
          'recaptchaToken': '',
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/hal+json',
          },
          responseType: ResponseType.plain,
        ),
      );

      print('Raw response: ${response.data}');

      final jsonResponse = jsonDecode(response.data);
      return {
        'statusCode': response.statusCode,
        ...jsonResponse,
      };
    } on DioException catch (e) {
      print("Error: ${e.message}");
      print("Raw response: ${e.response?.data}");
      return {
        'statusCode': e.response?.statusCode ?? 500,
        'error': 'فشل تسجيل الدخول: الرد من السيرفر غير متوقع.',
      };
    }
  }

  Future<void> setupAuthHeaderFromStorage() async {
    final token = await TokenHelper.getToken();
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}

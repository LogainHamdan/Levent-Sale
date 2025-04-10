import 'package:dio/dio.dart';

import '../../../../../../config/constants.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();

  late final Dio _dio;

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal() {
    _dio = Dio(
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

  Future<Response> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await _dio.post(registerUrl, data: userData);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

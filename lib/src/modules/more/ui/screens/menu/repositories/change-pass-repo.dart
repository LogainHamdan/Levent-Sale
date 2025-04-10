import 'package:dio/dio.dart';

import '../../../../../../config/constants.dart';

class ChangePasswordRepository {
  static final ChangePasswordRepository _instance = ChangePasswordRepository._internal();
  factory ChangePasswordRepository() => _instance;

  ChangePasswordRepository._internal();

  final Dio _dio = Dio();

  Future<Response> changePassword({
    required int userId,
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    final String url = updatePassUrl;

    try {
      final response = await _dio.post(
        url,
        data: {
          "userId": userId,
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        rethrow;
      }
    }
  }

  Future<Response> changePasswordWithToken({
    required String newPassword,
    required String newPasswordVerify,
    required String token,
  }) async {
    final String url = updatePassTokenUrl;

    try {
      final response = await _dio.put(
        url,
        data: {
          "newPassword": newPassword,
          "newPasswordVerify": newPasswordVerify,
          "token": token,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/hal+json',
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        rethrow;
      }
    }
  }
}

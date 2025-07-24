import 'package:dio/dio.dart';

import '../../../config/constants.dart';

class ChangePasswordRepository {
  static final ChangePasswordRepository _instance =
      ChangePasswordRepository._internal();
  factory ChangePasswordRepository() => _instance;

  ChangePasswordRepository._internal();

  final Dio _dio = Dio();

  Future<Response> changePassword(
    int userId,
    String newPassword,
    String oldPassword, {
    required String token,
  }) async {
    try {
      final response = await _dio.put(
        data: {
          "userId": userId,
          "newPassword": newPassword,
          "oldPassword": oldPassword,
        },
        updatePassUrl,
        options: Options(
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
            'Accept': 'application/hal+json',
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
}

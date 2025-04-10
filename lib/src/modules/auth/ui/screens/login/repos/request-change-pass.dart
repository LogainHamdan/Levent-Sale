import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';

class PasswordResetRepository {
  static final PasswordResetRepository _instance =
      PasswordResetRepository._internal();

  factory PasswordResetRepository() => _instance;

  PasswordResetRepository._internal();

  final Dio _dio = Dio();

  Future<Response> requestPasswordReset(String email) async {
    final String url = '$requestUpdatePassUrl/$email';

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/hal+json",
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      if (e.response != null) return e.response!;
      rethrow;
    }
  }
}

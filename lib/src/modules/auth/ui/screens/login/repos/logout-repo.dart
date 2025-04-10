import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutRepository {
  final Dio dio;

  LogoutRepository({Dio? dio}) : dio = dio ?? Dio();

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
}

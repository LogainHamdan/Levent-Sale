import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';

class UserProfileRepository {
  static final UserProfileRepository _instance =
      UserProfileRepository._internal();

  factory UserProfileRepository() {
    return _instance;
  }

  late final Dio _dio;

  UserProfileRepository._internal() {
    _dio = Dio(BaseOptions(
      headers: {'Accept': 'application/hal+json'},
    ));
  }

  Future<Response> getProfile(String token) async {
    return await _dio.get(
      profileUrl,
      options: Options(
        headers: {
          'Authorization': token,
        },
      ),
    );
  }

  Future<Response> getUserProfile(String token, int userId) async {
    return await _dio.get(
      '$profileUrl/$userId',
      options: Options(
        headers: {
          'Accept': 'application/hal+json',
        },
      ),
    );
  }
}

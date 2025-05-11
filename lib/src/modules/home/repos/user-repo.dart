import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';
import '../../auth/models/user.dart';

class UserRepository {
  final Dio _dio;

  UserRepository._internal() : _dio = Dio();

  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() => _instance;

  Future<List<User>> searchUsers(String username) async {
    final response = await _dio.get(
      searchUrl,
      queryParameters: {'username': username},
    );

    List data = response.data;
    return data.map((user) => User.fromJson(user)).toList();
  }
}

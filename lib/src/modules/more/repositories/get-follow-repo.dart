import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';
import '../models/followers.dart';
import '../models/following.dart';

class GetFollowRepository {
  static final GetFollowRepository _instance = GetFollowRepository._internal();

  factory GetFollowRepository() {
    return _instance;
  }

  late final Dio _dio;

  GetFollowRepository._internal() {
    _dio = Dio();
  }

  Future<List<FollowedUserModel>> getFollowingUsers(
      int userId, String authToken) async {
    try {
      final response = await _dio.get(
        "$followUrl/$userId",
        options: Options(headers: {'Authorization': 'Bearer $authToken'}),
      );

      final data = response.data as List;
      return data.map((json) => FollowedUserModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Error fetching following users: $e");
    }
  }

  Future<List<FollowerModel>> getFollowers(int userId) async {
    try {
      final response = await _dio.get('/users/followers/$userId');
      List data = response.data;
      return data.map((json) => FollowerModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Error fetching followers: $e");
    }
  }
}

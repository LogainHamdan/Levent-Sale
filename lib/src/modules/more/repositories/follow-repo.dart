import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';

import '../../auth/models/user.dart';
import '../models/follow.dart';

import '../models/profile.dart';

class FollowRepository {
  static final FollowRepository _instance = FollowRepository._internal();

  factory FollowRepository() {
    return _instance;
  }

  late final Dio _dio;

  FollowRepository._internal() {
    _dio = Dio();
  }

  Future<Response> unfollowUser(
      {required int followingId, required String token}) async {
    try {
      final response = await _dio.post(
        "$unfollowUrl/$followingId",
        options: Options(headers: {
          'Authorization': token,
          'Accept': 'application/hal+json'
        }),
      );
      print("Unfollowed successfully: ${response.data}");
      return response;
    } catch (e) {
      print("Unfollow failed: $e");
      rethrow;
    }
  }

  Future<Response> followUser(
      {required int followingId, required String token}) async {
    try {
      final response = await _dio.post(
        "$followUrl/$followingId",
        options: Options(
          headers: {'Authorization': token, 'Accept': 'application/hal+json'},
        ),
      );
      print("Followed successfully: ${response.data}");
      return response;
    } catch (e) {
      print("Follow failed: $e");
      rethrow;
    }
  }

  Future<Profile?> getProfile({required int userId}) async {
    try {
      print('$profileUrl/$userId');
      final response = await _dio.get(
        '$profileUrl/$userId',
        options: Options(headers: {'Accept': 'application/hal+json'}),
      );

      if (response.data != null) {
        return Profile.fromJson(response.data);
      } else {
        throw Exception('Failed to load user profile.');
      }
    } catch (e) {
      if (e is DioException) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      }
      throw Exception('Error fetching profile: $e');
    }
  }

  Future<List<FollowProfileModel>> getFollowingUsers(
      {required int userId}) async {
    try {
      final response = await _dio.get(
        "$followingUrl/$userId",
      );
      final data = response.data;
      if (data is List) {
        return data.map((json) => FollowProfileModel.fromJson(json)).toList();
      } else {
        throw Exception("Unexpected data format: not a List");
      }
    } catch (e) {
      throw Exception("Error fetching following users: $e");
    }
  }

  Future<List<FollowProfileModel>> getFollowers({required int userId}) async {
    try {
      final response = await _dio.get('$followersUrl/$userId');
      List data = response.data;
      print(data);

      return data.map((json) => FollowProfileModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Error fetching followers: $e");
    }
  }
}

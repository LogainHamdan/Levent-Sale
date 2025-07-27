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
        options: Options(responseType: ResponseType.plain, headers: {
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
          responseType: ResponseType.plain,
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

  Future<Profile?> getProfile({required int userId, int? myid}) async {
    try {
      print('$profileUrl/$userId');

      final response = await _dio.get(
        '$profileUrl/$userId',
        queryParameters: {'myid': myid},
        options: Options(headers: {'Accept': 'application/hal+json'}),
      );

      if (response.data != null) {
        print('Profile loaded successfully: ${response.data}');
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

  Future<List<User>> getFollowingUsers({
    required int userId,
    int? myId,
    int? page,
    int? size,
  }) async {
    try {
      final response = await _dio.get(
        "$followingUrl/$userId",
        queryParameters: {'myId': myId, 'page': page, 'size': size},
      );

      final responseData = response.data;
      print('following: ${responseData}');
      if (responseData is Map<String, dynamic> &&
          responseData['content'] is List) {
        final List<dynamic> contentList = responseData['content'];
        return contentList.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception("Unexpected data format: $responseData");
      }
    } catch (e) {
      throw Exception("Error fetching following users: $e");
    }
  }

  Future<List<User>> getFollowers({
    required int userId,
    int? myId,
    int? page,
    int? size,
  }) async {
    try {
      final response = await _dio.get(
        '$followersUrl/$userId',
        queryParameters: {'myId': myId, 'page': page, 'size': size},
      );

      final responseData = response.data;
      print('followers: ${responseData}');
      if (responseData is Map<String, dynamic> &&
          responseData['content'] is List) {
        final List<dynamic> contentList = responseData['content'];
        return contentList.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception("Unexpected data format: $responseData");
      }
    } catch (e) {
      throw Exception("Error fetching followers: $e");
    }
  }
}

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';

class FollowRepository {
  static final FollowRepository _instance = FollowRepository._internal();

  factory FollowRepository() {
    return _instance;
  }

  late final Dio _dio;

  FollowRepository._internal() {
    _dio = Dio();
  }

  Future<void> unfollowUser(int followingId, String token) async {
    try {
      final response = await _dio.post(
        "$unfollowUrl/$followingId",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      print("Unfollowed successfully: ${response.data}");
    } catch (e) {
      print("Unfollow failed: $e");
      rethrow;
    }
  }

  Future<void> followUser(int followingId, String token) async {
    try {
      final response = await _dio.post(
        "$followUrl/$followingId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("Followed successfully: ${response.data}");
    } catch (e) {
      print("Follow failed: $e");
      rethrow;
    }
  }
}

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';

class FollowRepository {
  final Dio _dio;

  FollowRepository(this._dio);

  Future<void> unfollowUser(int followingId, String token) async {
    try {
      final response = await _dio.post(
        unfollowUrl,
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
        followUrl,
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

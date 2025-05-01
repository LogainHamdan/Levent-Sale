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

  Future<Response> unfollowUser(
      {required int followingId, required String token}) async {
    try {
      final response = await _dio.post(
        "$unfollowUrl/$followingId",
        queryParameters: {'followingId': followingId},
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
        queryParameters: {'followingId': followingId},
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
}

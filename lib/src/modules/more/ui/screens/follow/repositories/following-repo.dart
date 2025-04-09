import 'package:dio/dio.dart';
import '../models/followed-model.dart';

class FollowingRepository {
  final Dio dio;

  FollowingRepository(this.dio);

  Future<List<FollowedUserModel>> getFollowingUsers(
      int userId, String authToken) async {
    try {
      final response = await dio.get(
        '/users/following/$userId',
        options: Options(headers: {'Authorization': 'Bearer $authToken'}),
      );

      final data = response.data as List;
      return data.map((json) => FollowedUserModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

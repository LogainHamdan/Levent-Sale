import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:dio/dio.dart';
import '../models/tag.dart';

class FavoriteRepository {
  static final FavoriteRepository _instance = FavoriteRepository._internal();

  final Dio _dio = Dio();

  FavoriteRepository._internal();

  factory FavoriteRepository() => _instance;
  Future<List<TagModel>?> getFavoriteTags(String token) async {
    try {
      final response = await _dio.get(
        getTagsUrl,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      print("Response data: ${response.data}");
      final List<dynamic> data = response.data;
      return data.map((e) => TagModel.fromJson(e)).toList();
    } catch (e) {
      if (e is DioException) {
        final status = e.response?.statusCode;
        final message = e.response?.data ?? "Unknown error";
        print("Error in API call: $status");
        print("Error details: $message");
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getFavoritesByTag(
      String token, String tagId) async {
    try {
      final response = await _dio.get(
        getFavoritesByTagUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        queryParameters: {'tagId': tagId},
      );

      final data = response.data as List;
      final favorites = data.map((item) => AdModel.fromJson(item)).toList();

      return {
        'favorites': favorites,
        'statusCode': response.statusCode,
      };
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Unknown error');
    }
  }

  Future<Response> createTag(
      {required String token, required String name}) async {
    return await _dio.post(
      createTagUrl,
      options: Options(headers: {'Authorization': token}),
      queryParameters: {'name': name},
    );
  }

  Future<Response> deleteFavorite(String favid) async {
    try {
      final response = await _dio.delete('$removeFromFavUrl/$favid');
      return response;
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<Response> checkFavoriteStatus({
    required int adId,
    required String authorizationToken,
  }) async {
    final response = await _dio.get(
      '$checkFavUrl/$adId',
      options: Options(headers: {
        'Authorization': authorizationToken,
      }),
    );
    return response;
  }

  Future<Response> addFavoriteToTag({
    required int adId,
    required String authorizationToken,
    required String tagId,
  }) async {
    try {
      final response = await _dio.post(
        '$addToTagUrl/$adId',
        options: Options(headers: {
          'Authorization': 'Bearer $authorizationToken',
        }),
        data: {
          'tagId': tagId,
          'adId': adId,
        },
      );
      return response;
    } on DioException catch (e) {
      print('Error in API call: ${e.response?.statusCode}');
      print('Error details: ${e.response?.data}');
      rethrow;
    }
  }

  Future<Response> deleteFavoriteTag({
    required String tagId,
    required String authorizationToken,
  }) async {
    try {
      final response = await _dio.delete(
        '$deleteTagUrl/$tagId',
        options: Options(headers: {
          'Authorization': authorizationToken,
        }),
      );
      return response;
    } on DioException catch (e) {
      throw e;
    }
  }
}

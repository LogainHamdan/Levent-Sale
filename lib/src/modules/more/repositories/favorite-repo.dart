import 'dart:convert';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:dio/dio.dart';
import '../../home/models/favorite-ad.dart';
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
          'Authorization': token,
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

  Future<List<AdModel>> getFavoritesByTag({
    required String token,
    required String tagId,
  }) async {
    try {
      final response = await _dio.get(
        getFavoritesByTagUrl,
        options: Options(
          headers: {'Authorization': token},
        ),
        queryParameters: {'tagId': tagId},
      );

      return (response.data as List)
          .map((json) => AdModel.fromJson(json))
          .toList();
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

  Future<Response> deleteFavorite(
      {required String token, required String favid}) async {
    try {
      final response = await _dio.delete('$removeFromFavUrl/$favid',
          options: Options(headers: {
            'Authorization': token,
          }),
          queryParameters: {'favid': favid});
      return response;
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<Response> checkFavoriteStatus({
    required dynamic adId,
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

  Future<FavoriteAd> addFavoriteToTag({
    required int adId,
    required String authorizationToken,
    required String tagId,
  }) async {
    try {
      final response = await _dio.post(
        '$addToTagUrl/$adId',
        options: Options(headers: {'Authorization': authorizationToken}),
        queryParameters: {'adId': adId, 'tagId': tagId},
      );

      if (response.statusCode == 200) {
        if (response.data is String) {
          print('Success message received: ${response.data}');
          return FavoriteAd(
            id: null,
            userId: null,
            tagId: tagId,
            adId: adId,
          );
        }

        print('Favorite added successfully: ${response.data}');
        return FavoriteAd.fromJson(response.data);
      } else {
        print('Failed to add favorite. Status code: ${response.statusCode}');
        throw Exception('Failed to add favorite');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
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

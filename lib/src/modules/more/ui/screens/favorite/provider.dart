import 'dart:core';

import 'package:Levant_Sale/src/modules/more/repositories/favorite-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../auth/repos/token-helper.dart';
import '../../../../sections/models/ad.dart';
import '../../../models/tag.dart';

class FavoriteProvider with ChangeNotifier {
  final FavoriteRepository repo = FavoriteRepository();
  List<TagModel> tags = [];
  TagModel? selectedTag;
  List<AdModel> favorites = [];
  bool isLoading = false;
  String errorMessage = '';
  TextEditingController tagController = TextEditingController();
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  void setSelectedTag(TagModel tag) {
    selectedTag = tag;
    notifyListeners();
  }

  Future<void> fetchTags(String token) async {
    print("fetchTags() called");

    if (tags.isNotEmpty || isLoading) {
      print("Already fetched or loading.");
      return;
    }

    isLoading = true;
    print("Fetching favorite tags...");

    try {
      final response = await repo.getFavoriteTags(token);
      print(" $response");

      if (response != null) {
        tags = response;
        errorMessage = '';
        print("${tags.map((e) => e.name).toList()}");
      } else {
        errorMessage = 'Failed to fetch tags: No data';
      }
    } catch (e) {
      if (e is DioException) {
        final status = e.response?.statusCode;
        final data = e.response?.data;
        final message = data is Map && data.containsKey('message')
            ? data['message']
            : data.toString();

        print("$status, Message: $message");
      } else {
        print("$e");
      }
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFavoritesByTag(String token, String tagId) async {
    isLoading = true;

    try {
      final result = await repo.getFavoritesByTag(token, tagId);
      favorites = result['favorites'];
      final statusCode = result['statusCode'];

      print('Status Code: $statusCode');
    } catch (e) {
      print('Error: ${e.toString()}');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTag(String name, String token) async {
    try {
      final response = await repo.createTag(name: name, token: token);

      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future<void> deleteFavorite(String favid) async {
    notifyListeners();

    try {
      final response = await repo.deleteFavorite(favid);
      print(response.data);
    } on DioException catch (e) {
      print(e.response?.statusCode);
    }
  }

  Future<void> checkFavoriteStatus({
    required int adId,
    required String authorizationToken,
  }) async {
    print('Checking favorite status for ad $adId'); // Debug print
    notifyListeners();

    try {
      print('Making API call...'); // Debug print
      final response = await repo.checkFavoriteStatus(
        adId: adId,
        authorizationToken: authorizationToken,
      );
      print('API response: ${response.statusCode}'); // Debug print

      if (response.statusCode == 200) {
        _isFavorite = response.data is bool ? response.data : false;
        print('Favorite status: $_isFavorite'); // Debug print
      } else {
        print('Unexpected status code: ${response.statusCode}'); // Debug print
        _isFavorite = false;
      }
    } on DioException catch (e) {
      print('DioError: ${e.message}'); // More detailed error print
      print('Error type: ${e.type}'); // DioError type
      print(
          'Error response: ${e.response?.statusCode}'); // Response if available
      _isFavorite = false;
    } catch (e) {
      print('General error: $e'); // Catch any other exceptions
      _isFavorite = false;
    }
  }

  Future<void> addToTag({
    required int adId,
    required String authorizationToken,
    required String tagId,
  }) async {
    notifyListeners();

    try {
      final response = await repo.addFavoriteToTag(
        adId: adId,
        authorizationToken: authorizationToken,
        tagId: tagId,
      );

      if (response.statusCode == 200) {
        print(response.data['favoriteId'] ?? response.data['id']);
      }
    } on DioException catch (e) {
      print(e.response?.statusCode);
    }
  }

  Future<void> deleteFavoriteTag({
    required String tagId,
    required String authorizationToken,
  }) async {
    notifyListeners();

    try {
      final response = await repo.deleteFavoriteTag(
        tagId: tagId,
        authorizationToken: authorizationToken,
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        print('tag deleted successfully!');
      }
    } on DioException catch (e) {
      print(e.response?.statusCode);
    }
  }
}

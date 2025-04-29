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
  Map<int, bool> favoriteStatus = {};
  TagModel? _currentTag;
  TagModel? get currentTag => _currentTag;

  bool isFavorite(int adId) {
    return favoriteStatus[adId] ?? false;
  }

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
      print("Response from API: $response");

      if (response != null && response.isNotEmpty) {
        tags = response;
        errorMessage = '';
        print("Tags fetched: ${tags.map((e) => e.name).toList()}");
      } else {
        errorMessage = 'Failed to fetch tags: No data';
        print("No data received");
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
        print("Error: $e");
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

  Future<TagModel?> createTag(String name, String token) async {
    try {
      final response = await repo.createTag(name: name, token: token);
      if (response.statusCode == 200) {
        print(response.statusCode);
        final tag = TagModel.fromJson(response.data);
        _currentTag = tag;
        selectedTag = tag;
        print(selectedTag?.id ?? '');
        notifyListeners();
        return tag;
      }
    } catch (e) {
      print('createTag error: $e');
    }
    return null;
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
      final response = await repo.checkFavoriteStatus(
        adId: adId,
        authorizationToken: authorizationToken,
      );
      print('API response: ${response.statusCode}'); // Debug print

      if (response.statusCode == 200) {
        favoriteStatus[adId] = response.data is bool ? response.data : false;
        print('Favorite status: ${favoriteStatus[adId]}'); // Debug print
      } else {
        print('Unexpected status code: ${response.statusCode}'); // Debug print
        favoriteStatus[adId] = false;
      }
    } on DioException catch (e) {
      print('DioError: ${e.message}'); // More detailed error print
      print('Error type: ${e.type}'); // DioError type
      print(
          'Error response: ${e.response?.statusCode}'); // Response if available
      favoriteStatus[adId] = false;
    } catch (e) {
      print('General error: $e'); // Catch any other exceptions
      favoriteStatus[adId] = false;
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

      print('Status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print(response.data['favoriteId'] ?? response.data['id']);
      } else {
        print('Add to tag failed: ${response.data}');
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

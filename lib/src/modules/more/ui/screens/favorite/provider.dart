import 'dart:core';

import 'package:Levant_Sale/src/modules/more/repositories/favorite-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../auth/repos/token-helper.dart';
import '../../../../home/models/favorite-ad.dart';
import '../../../../sections/models/ad.dart';
import '../../../models/tag.dart';

class FavoriteProvider with ChangeNotifier {
  final FavoriteRepository repo = FavoriteRepository();
  List<TagModel> tags = [];
  TagModel? selectedTag;
  Map<String, List<AdModel>> tagFavorites = {};
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

  Future<void> fetchFavoritesByTag({
    required String token,
    required String tagId,
  }) async {
    if (tagFavorites.containsKey(tagId)) return;

    isLoading = true;
    notifyListeners();

    try {
      final result = await repo.getFavoritesByTag(token: token, tagId: tagId);
      tagFavorites[tagId] = result;
      errorMessage = '';
    } catch (e) {
      errorMessage = e.toString();
      print('Error fetching favs by tag: $errorMessage');
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

        tags.add(tag);

        _currentTag = tag;
        selectedTag = tag;

        print("New tag added: ${tag.id}");
        notifyListeners();
        return tag;
      }
    } catch (e) {
      print('createTag error: $e');
    }
    return null;
  }

  Future<void> deleteFavorite({
    required String favid,
    required String token,
  }) async {
    try {
      final response = await repo.deleteFavorite(token: token, favid: favid);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print('delete fav done: $favid');

        int adId = int.tryParse(favid) ?? 0;
        if (favoriteStatus.containsKey(adId)) {
          favoriteStatus.remove(adId);
          notifyListeners();
        }
      } else {
        print('delete fav failed: ${response.data}');
      }
    } on DioException catch (e) {
      print(e.response?.statusCode);
    }
  }

  Future<void> checkFavoriteStatus({
    required int adId,
    required String authorizationToken,
  }) async {
    print('Checking favorite status for ad $adId');
    notifyListeners();

    try {
      final response = await repo.checkFavoriteStatus(
        adId: adId,
        authorizationToken: authorizationToken,
      );
      print('check: ${response.statusCode}');

      if (response.statusCode == 200) {
        favoriteStatus[adId] = response.data is bool ? response.data : false;
        print('Favorite status: ${favoriteStatus[adId]}');
      } else {
        print('Unexpected status code: ${response.statusCode}');
        favoriteStatus[adId] = false;
      }
    } on DioException catch (e) {
      print('DioError: ${e.message}');
      print('Error type: ${e.type}');
      print('Error response: ${e.response?.statusCode}');
      favoriteStatus[adId] = false;
    } catch (e) {
      print('General error: $e');
      favoriteStatus[adId] = false;
    }
  }

  Future<bool> addToTag(
    BuildContext context, {
    required int adId,
    required String authorizationToken,
    required String tagId,
  }) async {
    try {
      final favoriteAd = await repo.addFavoriteToTag(
        adId: adId,
        authorizationToken: authorizationToken,
        tagId: tagId,
      );

      print('Favorite added to tag: $favoriteAd');

      favoriteStatus[adId] = true;
      notifyListeners();
      return true;
    } on DioException catch (e) {
      print('DioException: ${e.response?.statusCode}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }

  Future<void> deleteFavoriteTag({
    required String tagId,
    required String authorizationToken,
  }) async {
    try {
      final response = await repo.deleteFavoriteTag(
        tagId: tagId,
        authorizationToken: authorizationToken,
      );

      if (response.statusCode == 200) {
        tagFavorites.remove(tagId);

        tags.removeWhere((tag) => tag.id == tagId);

        if (selectedTag?.id == tagId) {
          selectedTag = null;
        }

        notifyListeners();
        print('Tag deleted successfully!');
      }
    } on DioException catch (e) {
      print(e.response?.statusCode);
    }
  }

  Future<void> deleteFavoriteAndRefresh({
    required String favid,
    required String token,
    required String tagId,
  }) async {
    await deleteFavorite(favid: favid, token: token);
    // بعد الحذف، أعد جلب المفضلة لهذا التاج
    tagFavorites.remove(tagId); // احذف القائمة القديمة حتى يتم إعادة جلبها
    await fetchFavoritesByTag(token: token, tagId: tagId);
    notifyListeners();
  }
}

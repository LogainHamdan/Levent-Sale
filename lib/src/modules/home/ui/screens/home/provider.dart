import 'package:Levant_Sale/src/modules/sections/models/root-category.dart';
import 'package:Levant_Sale/src/modules/sections/repos/ad.dart';
import 'package:flutter/material.dart';

import '../../../../sections/models/ad.dart';

class HomeProvider extends ChangeNotifier {
  final Map<String, bool> _favorites = {};
  int _currentIndex = 0;
  final ScrollController scrollController = ScrollController();
  RootCategoryModel? _selectedCategory;
  AdRepository repo = AdRepository();
  List<AdModel> allAds = [];
  List<AdModel> userAds = [];
  AdModel? _selectedAd;

  bool isLoading = false;
  String? error;

  int get currentIndex => _currentIndex;
  AdModel? get selectedAd => _selectedAd;

  RootCategoryModel? get selectedCategory => _selectedCategory;

  bool isFavorite(String productKey) => _favorites[productKey] ?? false;

  void toggleFavorite(String productKey) {
    _favorites[productKey] =
        !_favorites.containsKey(productKey) || !_favorites[productKey]!;
    notifyListeners();
  }

  void selectAd(AdModel ad) {
    _selectedAd = ad;
    notifyListeners();
  }

  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }

  void scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  void selectCategory(RootCategoryModel category) {
    _selectedCategory = category;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> loadAds({int page = 0, int size = 8, List<int>? ids}) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await repo.getAds(page: page, size: size, ids: ids);
      print('Raw response content: ${response.data['content']}');

      if (response.statusCode == 200) {
        List<dynamic> content = response.data['content'];
        print(response.statusCode);
        print(response.data);
        for (var item in content) {
          try {
            final ad = AdModel.fromJson(item);
            print('Parsed ad: ${ad.title}');
          } catch (e) {
            print('Failed to parse ad: $e');
          }
        }

        allAds = content.map((e) => AdModel.fromJson(e)).toList();
      }
    } catch (e) {
      error = 'Failed to load ads: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadUserAds({required int userId}) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      userAds = await repo.getUserAds(userId: userId);
      print('userAds: $userAds');
      for (var ad in userAds) {
        print('Loaded ad: ${ad.title}');
      }
    } catch (e) {
      error = 'Failed to load ads: $e';
      print(error);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<AdModel?> getAdById(int id) async {
    print('get ad invoked');
    isLoading = true;
    error = null;

    try {
      final ad = await repo.getAdById(id: id);
      print('get ad done');

      if (ad != null) {
        _selectedAd = ad;
        return ad;
      } else {
        error = "Failed to load ad: empty or invalid response.";
        return null;
      }
    } catch (e) {
      error = "Exception while loading ad: $e";
      return null;
    } finally {
      isLoading = false;
    }
  }
}

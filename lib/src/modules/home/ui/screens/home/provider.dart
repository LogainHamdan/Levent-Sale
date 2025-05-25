import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:Levant_Sale/src/modules/sections/models/root-category.dart';
import 'package:Levant_Sale/src/modules/sections/repos/ad.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../../../../sections/models/ad.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider(){
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': 'HomeScreen',
      },
    );
  }
  final Map<String, bool> _favorites = {};
  int _currentIndex = 0;
  final ScrollController scrollController = ScrollController();
  Category? _selectedCategory;
  AdRepository repo = AdRepository();
  List<AdModel> allAds = [];
  List<AdModel> userAds = [];
  AdModel? _selectedAd;

  bool isLoading = false;
  String? error;

  int get currentIndex => _currentIndex;
  AdModel? get selectedAd => _selectedAd;

  Category? get selectedCategory => _selectedCategory;

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

  void selectCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> loadAds(
      {String? token, int page = 0, int size = 8, List<int>? ids}) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response =
          await repo.getAds(token: token, page: page, size: size, ids: ids);
      print('Full response: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['content'] is! List) {
          throw Exception('Content is not a list');
        }

        List<AdModel> parsedAds = [];
        for (var item in response.data['content']) {
          try {
            print('Processing item: $item');
            final ad = AdModel.fromJson(item);
            parsedAds.add(ad);
            print('All ads content:');
            parsedAds.forEach((ad) {
              print(
                  'Ad ID: ${ad.id}, Title: ${ad.title}, Description: ${ad.description}, ad fav: ${ad.tagId}');
            });
          } catch (e, stackTrace) {
            print('Failed to parse ad: $e');
            print('Stack trace: $stackTrace');
            print('Problematic item: $item');
          }
        }

        allAds = parsedAds;
      }
    } catch (e) {
      error = 'Failed to load ads: $e';
      print('Error loading ads: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadUserAds({required int userId}) async {
    isLoading = true;
    error = null;

    try {
      userAds = await repo.getUserAds(userId: userId);
      print('user Ads after repo: $userAds');
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

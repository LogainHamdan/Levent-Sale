import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/notifications/provider.dart';
import 'package:Levant_Sale/src/modules/sections/models/getAdDTO.dart';
import 'package:Levant_Sale/src/modules/sections/models/root-category.dart';
import 'package:Levant_Sale/src/modules/sections/repos/ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../sections/models/ad.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': 'HomeScreen',
      },
    );

  }
  initialize(context)async{
    final notificationsProvider =
    Provider.of<NotificationProvider>(context, listen: false);
    final categoryProvider =
    Provider.of<CreateAdChooseSectionProvider>(context,
        listen: false);
    final token = await TokenHelper.getToken();
    await loadAds(token: token);
    await categoryProvider.fetchCategories();
    await notificationsProvider.getNotificationStats(
        token: token ?? '');
  }
  final Map<String, bool> _favorites = {};
  int _currentIndex = 0;
  final ScrollController scrollController = ScrollController();
  Category? _selectedCategory;
  AdRepository repo = AdRepository();
  List<AdModel> allAds = [];
  List<AdModel> userAds = [];
  AdModel? _selectedAd;
  GetAdDTO? _selectedAdForMap;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;

  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreData => _hasMoreData;

  bool isLoading = false;
  String? error;

  int get currentIndex => _currentIndex;
  AdModel? get selectedAd => _selectedAd;
  GetAdDTO? get selectedAdForMap => _selectedAdForMap;

  Category? get selectedCategory => _selectedCategory;
  int _currentPage = 0;
  int _totalElements = 0;
  int _totalPages = 0;
  int _pageSize = 8;



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
  Future<void> loadAds({
    String? token,
    int page = 0,
    int? size,
    List<int>? ids,
    bool append = false,
  }) async {
    if (append) {
      _isLoadingMore = true;
    } else {
      isLoading = true;
      allAds.clear(); //
    }
    error = null;
    notifyListeners();

    try {
      final actualSize = size ?? _pageSize;
      final response = await repo.getAds(
        token: token,
        page: page,
        size: actualSize,
        ids: ids,
      );

      print('Full response: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['content'] is! List) {
          throw Exception('Content is not a list');
        }
        _currentPage = data['number'] ?? page;
        _pageSize = data['size'] ?? actualSize;
        _totalElements = data['totalElements'] ?? 0;
        _totalPages = data['totalPages'] ?? 0;
        _hasMoreData = _currentPage < (_totalPages - 1);
        List<AdModel> parsedAds = [];
        for (var item in data['content']) {
          try {
            final ad = AdModel.fromJson(item);
            parsedAds.add(ad);
          } catch (e, stackTrace) {
            print('Failed to parse ad: $e');
            print('Stack trace: $stackTrace');
            print('Problematic item: $item');
          }
        }
        if (append) {
          allAds.addAll(parsedAds);
          print('Added ${parsedAds.length} ads. Total: ${allAds.length}');
        } else {
          allAds = parsedAds;
          print('Loaded ${parsedAds.length} ads');
        }

        print('Current Page: $_currentPage, Total Pages: $_totalPages, Has More: $_hasMoreData');
      }
    } catch (e) {
      error = 'Failed to load ads: $e';
      print('Error loading ads: $e');
    }

    if (append) {
      _isLoadingMore = false;
    } else {
      isLoading = false;
    }
    notifyListeners();
  }


  Future<void> loadMoreAds({String? token}) async {
    if (_isLoadingMore || !_hasMoreData) return;

    print('Loading more ads... Current page: $_currentPage');
    await loadAds(
        token: token,
        page: _currentPage + 1,
        append: true
    );
  }

  Future<void> refreshAds({String? token}) async {
    _currentPage = 0;
    _hasMoreData = true;
    await loadAds(token: token, page: 0, append: false);
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

  Future<GetAdDTO?> getAdByIdForMap(int id) async {
    print('get ad invoked');
    isLoading = true;
    error = null;

    try {
      final ad = await repo.getAdByIdForMap(id: id);
      print('get ad done');

      if (ad != null) {
        _selectedAdForMap = ad;
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

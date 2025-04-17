import 'package:Levant_Sale/src/modules/sections/models/root-category.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final Map<String, bool> _favorites = {};
  int _currentIndex = 0;
  final ScrollController scrollController = ScrollController();
  RootCategoryModel? _selectedCategory;
  int get currentIndex => _currentIndex;
  RootCategoryModel? get selectedCategory => _selectedCategory;

  bool isFavorite(String productKey) => _favorites[productKey] ?? false;

  void toggleFavorite(String productKey) {
    _favorites[productKey] =
        !_favorites.containsKey(productKey) || !_favorites[productKey]!;
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
}

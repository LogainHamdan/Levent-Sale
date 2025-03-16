import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final Map<String, bool> _favorites = {};
  int _currentIndex = 0;
  final ScrollController scrollController = ScrollController();

  int get currentIndex => _currentIndex;
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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

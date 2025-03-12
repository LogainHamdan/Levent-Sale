import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final Map<String, bool> _favorites = {};
  int _currentIndex = 0;

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
}

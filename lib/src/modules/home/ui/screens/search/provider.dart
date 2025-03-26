import 'package:flutter/material.dart';


class SearchProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<String> searchResults = [];

  final List<String> allResults = [
    'Apple iPhone 13',
    'Samsung Galaxy S21',
    'Google Pixel 6',
    'OnePlus 9',
  ];

  // تحديث نتائج البحث بناءً على النص المدخل
  void searchQueryUpdated() {
    String query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      searchResults = [];
    } else {
      searchResults = allResults
          .where((result) => result.toLowerCase().contains(query))
          .toList();
    }

    notifyListeners(); // إعلام المستمعين (Widgets) بالتحديث
  }
}

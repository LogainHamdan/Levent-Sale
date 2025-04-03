import 'package:Levant_Sale/src/modules/home/ui/screens/home/data.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<String> searchResults = [];

  void searchQueryUpdated() {
    String query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      searchResults = [];
    } else {
      searchResults = categoryNames
          .where((result) => result.toLowerCase().contains(query))
          .toList();
    }

    notifyListeners();
  }
}

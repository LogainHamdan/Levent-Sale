import 'package:flutter/material.dart';

class ChoosesSectionProvider extends ChangeNotifier {
  int? _selectedCategoryIndex;

  int? get selectedCategoryIndex => _selectedCategoryIndex;

  void setSelectedCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }
}

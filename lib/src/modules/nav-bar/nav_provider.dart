import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int selectedIndex = 0;

  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

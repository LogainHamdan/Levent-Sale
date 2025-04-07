import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int _currentIndex = 3;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

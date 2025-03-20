import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  bool isLoggedIn = false;

  void toggleAuth() {
    isLoggedIn = !isLoggedIn;
    notifyListeners();
  }
}

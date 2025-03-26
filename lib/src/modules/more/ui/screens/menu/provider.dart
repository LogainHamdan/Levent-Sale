import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  bool isLoggedIn = true;

  void toggleAuth() {
    isLoggedIn = !isLoggedIn;
    notifyListeners();
  }
}

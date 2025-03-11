import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _passwordVisible = false;
  bool _rememberMe = false;

  bool get passwordVisible => _passwordVisible;
  bool get rememberMe => _rememberMe;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    if (value != null) {
      _rememberMe = value;
      notifyListeners();
    }
  }
}

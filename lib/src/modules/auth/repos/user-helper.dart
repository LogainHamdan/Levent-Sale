import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../ui/screens/login/provider.dart';

class UserHelper {
  static const _userKey = 'user';
  static const _rememberMeKey = 'rememberMe';

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
    print('User saved: $userJson');
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    return userJson != null;
  }

  static Future<void> saveUserWithRememberMe(
      bool rememberMe, BuildContext context) async {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();

    final userJson = jsonEncode(User(
        email: provider.emailController.text,
        password: provider.passwordController.text));
    await prefs.setString(_userKey, userJson);
    await prefs.setBool(_rememberMeKey, rememberMe);
    print('User saved with rememberMe: $userJson');
  }

  static Future<User?> getRememberedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool(_rememberMeKey) ?? false;
    if (!rememberMe) return null;

    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      print('User retrieved: $userJson');
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static Future<bool> getRememberMeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }

  static Future<void> removeRememberMeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_rememberMeKey);
    print('Remember Me status removed');
  }
}

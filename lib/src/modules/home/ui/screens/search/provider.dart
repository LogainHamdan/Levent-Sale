import 'package:Levant_Sale/src/modules/home/ui/screens/home/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../models/user-model.dart';
import '../../../repos/user-repo.dart';

class SearchProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  TextEditingController searchController = TextEditingController();

  List<UserModel> results = [];
  bool isLoading = false;
  String? error;

  Future<void> searchUsers() async {
    final query = searchController.text.trim();

    if (query.isEmpty) {
      results = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final users = await _userRepository.searchUsers(query);
      results = users;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}

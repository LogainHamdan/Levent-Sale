import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/home/repos/search-repo.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../models/address.dart';
import '../../../repos/user-repo.dart';

class SearchProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  final SearchRepository _searchRepository = SearchRepository();

  String? _errorSearch;

  TextEditingController searchController = TextEditingController();
  bool _isLoadingSearch = false;
  Response? _response;

  List<User> users = [];
  bool isLoading = false;
  String? error;
  Response? get response => _response;
  bool get isLoadingSearch => _isLoadingSearch;
  List<dynamic> _ads = [];
  String? get errorSearch => _errorSearch;

  List<dynamic> get ads => _ads;
  Future<void> searchUsers() async {
    final query = searchController.text.trim();

    if (query.isEmpty) {
      users = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final usersFiltered = await _userRepository.searchUsers(query);
      users = usersFiltered;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> searchAds(
      {required String query, int? page = 0, int? size = 8}) async {
    _isLoadingSearch = true;
    _errorSearch = null;
    _ads = [];
    notifyListeners();

    try {
      final res = await _searchRepository.searchAds(
          query: query, page: page, size: size);
      print(res.statusCode);
      if (res.statusCode == 200) {
        print(res.data);
        final data = res.data;
        final content = data['content'] ?? [];
        _ads = content;
      } else {
        _errorSearch = "Server error: ${res.statusCode}";
      }
    } catch (e) {
      _errorSearch = "Something went wrong: $e";
    } finally {
      _isLoadingSearch = false;
      notifyListeners();
    }
  }
}

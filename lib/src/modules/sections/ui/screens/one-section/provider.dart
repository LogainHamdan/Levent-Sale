import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:flutter/material.dart';

import '../../../models/filter.dart';
import '../../../repos/ad.dart';

class SectionProvider extends ChangeNotifier {
  AdRepository repo = AdRepository();
  List<AdModel> _adsByCategory = [];
  List<AdModel> get adsByCategory => _adsByCategory;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;
  Future<void> fetchCategoryAds(
    FilterRequestDTO filter, {
    required String categoryId,
    int? page,
    int? size,
  }) async {
    _isLoading = true;
    _error = null;

    try {
      final token = await TokenHelper.getToken();
      final response = await repo.getCategoryAds(
        filter,
        categoryId: categoryId,
        token: token,
        page: page,
        size: size,
      );

      final List data = response.data['data'];
      _adsByCategory = data.map((json) => AdModel.fromJson(json)).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

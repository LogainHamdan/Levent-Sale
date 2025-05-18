import 'package:flutter/material.dart';

import '../../../../../models/root-category.dart';
import '../../../../../repos/category-repo.dart';

class UpdateAdChooseSectionProvider extends ChangeNotifier {
  int? _selectedCategoryIndex;
  int? _selectedSubcategoryIndex;

  final CategoriesRepository _repo = CategoriesRepository();
  List<Category> rootCategories = [];
  List<Category> subcategories = [];
  List<Category> categoryChildren = [];
  Category? _selectedSubcategory;
  bool isLoading = false;
  Category? category;
  Category? categoryChild;
  String _categoryPath = '';

  int? get selectedCategoryIndex => _selectedCategoryIndex;

  int? get selectedSubcategoryIndex => _selectedSubcategoryIndex;
  String get categoryPath => _categoryPath;
  Category? get selectedSubcategory => _selectedSubcategory;

  void setSelectedCategory(int index) {
    _selectedCategoryIndex = index;
    var selectedId = rootCategories[index].id;
    _categoryPath = selectedId.toString();
    print('current path: $_categoryPath');
    notifyListeners();
  }

  void setSelectedSubcategory(int index) {
    _selectedSubcategoryIndex = index;
    _selectedSubcategory = subcategories[index];
    if (_selectedSubcategory != null) {
      _categoryPath += '/${_selectedSubcategory!.id}';
    }
    print('current path: $_categoryPath');

    notifyListeners();
  }

  Category? get selectedCategory => (selectedCategoryIndex! >= 0 &&
          selectedCategoryIndex! < rootCategories.length)
      ? rootCategories[selectedCategoryIndex!]
      : null;
  Future<void> fetchCategories() async {
    isLoading = true;
    try {
      print('Fetching categories...');
      final response = await _repo.fetchCategories();
      print('Raw response: $response'); // Add this
      rootCategories = response;
    } catch (e) {
      print('Failed to load categories: ${e.toString()}');
      print('Stack trace: ${e}');
      rootCategories = [];
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchCategoryById(int id) async {
    final response = await _repo.getCategoryById(id);

    if (response.statusCode == 200) {
      _selectedSubcategory = Category.fromJson(response.data);
      print('selected subcategory id: ${_selectedSubcategory?.id}');
    }
  }

  Future<void> fetchSubcategories(int id) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _repo.getSubcategories(id);
      print('Subcategories response: ${response.data}');

      if (response.statusCode == 200) {
        subcategories = (response.data as List)
            .map((json) => Category.fromJson(json))
            .toList();
      } else {
        subcategories = [];
      }
    } catch (e) {
      subcategories = [];
      print('Error fetching subcategories: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategoryChildren(int id) async {
    final response = await _repo.getCategoryChildren(id);

    if (response.statusCode == 200) {
      categoryChild = Category.fromJson(response.data);
    } else {
      categoryChild = null;
    }
  }
}

import 'package:Levant_Sale/src/modules/sections/models/category-child.dart';
import 'package:flutter/material.dart';
import '../../../models/root-category.dart';
import '../../../models/subcategory.dart';
import '../../../repos/category-repo.dart';

class CreateAdChooseSectionProvider extends ChangeNotifier {
  int? _selectedCategoryIndex;
  final CategoriesRepository _repo = CategoriesRepository();
  List<RootCategoryModel> rootCategories = [];
  List<SubcategoryModel> subcategories = [];
  List<CategoryChildModel> categoryChildren = [];

  bool isLoading = false;
  RootCategoryModel? category;
  CategoryChildModel? categoryChild;

  int? get selectedCategoryIndex => _selectedCategoryIndex;

  void setSelectedCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }

  RootCategoryModel? get selectedCategory => (selectedCategoryIndex! >= 0 &&
          selectedCategoryIndex! < rootCategories.length)
      ? rootCategories[selectedCategoryIndex!]
      : null;
  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      rootCategories = await _repo.fetchCategories();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategoryById(int id) async {
    final response = await _repo.getCategoryById(id);

    if (response.statusCode == 200) {
      category = RootCategoryModel.fromJson(response.data);
    } else {
      category = null;
    }

    notifyListeners();
  }

  Future<void> fetchSubcategories(int id) async {
    final response = await _repo.getSubcategories(id);

    if (response.statusCode == 200) {
      subcategories = (response.data as List)
          .map((json) => SubcategoryModel.fromJson(json))
          .toList();
    } else {
      subcategories = [];
    }

    notifyListeners();
  }

  Future<void> fetchCategoryChildren(int id) async {
    final response = await _repo.getCategoryChildren(id);

    if (response.statusCode == 200) {
      categoryChild = CategoryChildModel.fromJson(response.data);
    } else {
      categoryChild = null;
    }

    notifyListeners();
  }
}

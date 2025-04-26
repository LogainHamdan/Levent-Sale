import 'package:Levant_Sale/src/modules/sections/models/category-child.dart';
import 'package:flutter/material.dart';
import '../../../models/root-category.dart';
import '../../../models/subcategory.dart';
import '../../../repos/category-repo.dart';

class CreateAdChooseSectionProvider extends ChangeNotifier {
  int? _selectedCategoryIndex;
  int? _selectedSubcategoryIndex;

  final CategoriesRepository _repo = CategoriesRepository();
  List<RootCategoryModel> rootCategories = [];
  List<SubcategoryModel> subcategories = [];
  List<CategoryChildModel> categoryChildren = [];
  SubcategoryModel? _selectedSubcategory;

  bool isLoading = false;
  RootCategoryModel? category;
  CategoryChildModel? categoryChild;

  int? get selectedCategoryIndex => _selectedCategoryIndex;

  int? get selectedSubcategoryIndex => _selectedSubcategoryIndex;

  SubcategoryModel? get selectedSubcategory => _selectedSubcategory;

  void setSelectedCategory(int index) {
    _selectedCategoryIndex = index;
  }

  void setSelectedSubcategory(int index) {
    _selectedSubcategoryIndex = index;
    _selectedSubcategory = subcategories[index];
    notifyListeners();
  }

  RootCategoryModel? get selectedCategory => (selectedCategoryIndex! >= 0 &&
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
      print('Stack trace: ${e}'); // Add this for more details
      rootCategories = [];
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchCategoryById(int id) async {
    final response = await _repo.getCategoryById(id);

    if (response.statusCode == 200) {
      category = RootCategoryModel.fromJson(response.data);
    } else {
      category = null;
    }
  }

  Future<void> fetchSubcategories(int id) async {
    isLoading = true;
    notifyListeners(); // Notify for loading state

    try {
      final response = await _repo.getSubcategories(id);
      print('Subcategories response: ${response.data}'); // Debug print

      if (response.statusCode == 200) {
        subcategories = (response.data as List)
            .map((json) => SubcategoryModel.fromJson(json))
            .toList();
      } else {
        subcategories = [];
      }
    } catch (e) {
      subcategories = [];
      print('Error fetching subcategories: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify after completion
    }
  }

  Future<void> fetchCategoryChildren(int id) async {
    final response = await _repo.getCategoryChildren(id);

    if (response.statusCode == 200) {
      categoryChild = CategoryChildModel.fromJson(response.data);
    } else {
      categoryChild = null;
    }
  }


}

import 'package:flutter/material.dart';
import '../../../models/root-category.dart';
import '../../../repos/category-repo.dart';

class CreateAdChooseSectionProvider extends ChangeNotifier {
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

  Category? get selectedCategory => (selectedCategoryIndex! >= 0 &&
          selectedCategoryIndex! < rootCategories.length)
      ? rootCategories[selectedCategoryIndex!]
      : null;
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

  void setSelectedSubcategoryById(int? subcategoryId) {
    if (subcategoryId == null) return;
    int index = subcategories.indexWhere((sub) => sub.id == subcategoryId);
    if (index != -1) {
      setSelectedSubcategory(index);
    }
  }

  void resetCategorySelection() {
    _selectedCategoryIndex = null;
    category = null;
    _categoryPath = '';
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    isLoading = true;
    try {
      print('Fetching categories...');
      final response = await _repo.fetchCategories();
      print('Raw response: $response');
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
        final data = response.data['categoryNameDTO'];
        if (data is List) {
          subcategories = data.map((json) => Category.fromJson(json)).toList();
        } else {
          subcategories = [];
          print('Unexpected response format: ${response.data}');
        }
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

  Future<void> navigateBack() async {
    if (_categoryPath.isEmpty) return;

    final pathParts = _categoryPath.split('/');

    // حالة خاصة: الرجوع من الجذر
    if (pathParts.length == 1) {
      _categoryPath = '';
      _selectedSubcategory = null;
      subcategories = rootCategories;
      notifyListeners();
      return;
    }

    // إنشاء المسار الجديد بإزالة آخر جزء
    final newPath = pathParts.sublist(0, pathParts.length - 1).join('/');
    final newParentId = int.parse(pathParts[pathParts.length - 2]);

    // تحديث المسار أولاً
    _categoryPath = newPath;
    print('new path: $newPath');
    print('current subcategory id: $newParentId');
    await fetchCategoryById(newParentId);
    print('current subcategory : ${_selectedSubcategory?.toJson()}');

    // جلب أبناء الوالد الجديد
    await fetchSubcategories(newParentId);
    print(
        'current subcategories id: ${subcategories.map((e) => e.toJson()).toList()}');

    notifyListeners();
  }
}

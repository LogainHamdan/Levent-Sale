import 'package:flutter/material.dart';
import '../../../models/car.dart';
import '../../../models/root-category.dart';
import '../../../repos/car-repo.dart';
import '../../../repos/category-repo.dart';

enum SelectionState {
  none,
  year,
  yearBrand,
  yearBrandModel,
  yearBrandModelTrans,
}

class CreateAdChooseSectionProvider extends ChangeNotifier {
  int? _selectedCategoryIndex;
  int? _selectedSubcategoryIndex;
  final CarRepository _carRepo = CarRepository();
  SelectionState currentSelection = SelectionState.none;

  final CategoriesRepository _repo = CategoriesRepository();
  List<Category> rootCategories = [];
  List<Category> subcategories = [];
  List<Category> categoryChildren = [];
  Category? _selectedSubcategory;

  bool isLoading = false;
  Category? category;
  Category? categoryChild;
  String _categoryPath = '';
  bool isCar = false;

  List _years = [];
  List _models = [];
  List _trans = [];
  List _brands = [];
  List<Car> _cars = [];

  int? _selectedYear;
  String? _selectedModel;
  String? _selectedTrans;
  String? _selectedBrand;

  String? _selectedFuel;
  String? _selectedMPG;
  String? _selectedCylinders;
  String? _selectedDrive;
  String? _selectedClass;

  List get years => _years;

  List get models => _models;

  List get trans => _trans;

  List get brands => _brands;

  List get cars => _cars;

  int? get selectedYear => _selectedYear;

  String? get selectedModel => _selectedModel;

  String? get selectedTrans => _selectedTrans;

  String? get selectedBrand => _selectedBrand;

  String? get selectedFuel => _selectedFuel;

  String? get selectedMPG => _selectedMPG;

  String? get selectedCylinders => _selectedCylinders;

  String? get selectedDrive => _selectedDrive;

  String? get selectedClass => _selectedClass;

  void setYears(List<int> values) {
    _years = values;
    notifyListeners();
  }

  void setModels(List<String> values) {
    _models = values;
    notifyListeners();
  }

  void setTrans(List<String> values) {
    _trans = values;
    notifyListeners();
  }

  void setBrands(List<String> values) {
    _brands = values;
    notifyListeners();
  }

  void setSelectedYear(int value) {
    _selectedYear = value;
    notifyListeners();
  }

  void setSelectedModel(String value) {
    _selectedModel = value;
    notifyListeners();
  }

  void setSelectedTrans(String value) {
    _selectedTrans = value;
    notifyListeners();
  }

  void setSelectedBrand(String value) {
    _selectedBrand = value;
    notifyListeners();
  }

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
      final response = await _repo.fetchCategories();
      rootCategories = response;
      rootCategories.reversed;
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
      isCar = isCar || response.data['car'] == true;
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

    if (pathParts.length == 1) {
      _categoryPath = '';
      _selectedSubcategory = null;
      subcategories = rootCategories;
      notifyListeners();
      return;
    } else if (isCar) {
      switch (currentSelection) {
        case SelectionState.yearBrandModelTrans:
          _selectedTrans = null;
          currentSelection = SelectionState.yearBrandModel;
          print('selected trans: $_selectedTrans');

          break;
        case SelectionState.yearBrandModel:
          _selectedModel = null;
          _trans = [];

          currentSelection = SelectionState.yearBrand;
          print('selected model: $_selectedModel');

          break;
        case SelectionState.yearBrand:
          _selectedBrand = null;
          _models = [];
          currentSelection = SelectionState.year;
          print('selected brand: $_selectedBrand');

          break;
        case SelectionState.year:
          _selectedYear = null;
          _brands = [];
          print('selected year: $_selectedYear');

          currentSelection = SelectionState.none;
        case SelectionState.none:
          _years = [];
          _selectedSubcategory = null;
          subcategories = [];
          break;
      }
      notifyListeners();
    }
    final newPath = pathParts.sublist(0, pathParts.length - 1).join('/');
    final newParentId = int.parse(pathParts[pathParts.length - 2]);

    _categoryPath = newPath;
    print('new path: $newPath');
    print('current subcategory id: $newParentId');
    await fetchCategoryById(newParentId);
    print('current subcategory : ${_selectedSubcategory?.toJson()}');

    await fetchSubcategories(newParentId);
    print(
        'current subcategories id: ${subcategories.map((e) => e.toJson()).toList()}');

    notifyListeners();
  }

  Future<void> fetchYears() async {
    isLoading = true;
    try {
      final response = await _carRepo.getYears();
      _years = response;
      currentSelection = SelectionState.year;
      print('current selection: $currentSelection');
    } catch (e) {
      print('Failed to load years in provider: ${e.toString()}');
      _years = [];
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchBrands() async {
    isLoading = true;
    try {
      print('getting brand for the year $selectedYear');
      final response = await _carRepo.getBrands(year: _selectedYear ?? 0);
      _brands = response;
      currentSelection = SelectionState.yearBrand;
      print('current selection: $currentSelection');
    } catch (e) {
      print('Failed to load brands in provider: ${e.toString()}');
      _brands = [];
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchModels() async {
    isLoading = true;
    try {
      print(
          'getting model for the year and brand $selectedYear $selectedBrand');
      final response = await _carRepo.getModels(
          year: _selectedYear ?? 0, brand: _selectedBrand ?? '');
      _models = response;
      currentSelection = SelectionState.yearBrandModel;
      print('current selection: $currentSelection');
    } catch (e) {
      print('Failed to load models in provider: ${e.toString()}');
      _models = [];
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchTransmissions() async {
    isLoading = true;
    try {
      print(
          'getting trans for the year, brand and model $selectedYear $selectedBrand $selectedModel');
      final response = await _carRepo.getTransmissions(
          year: _selectedYear ?? 0,
          brand: _selectedBrand ?? '',
          model: _selectedModel ?? '');
      _trans = response;
      currentSelection = SelectionState.yearBrandModelTrans;
      print('current selection: $currentSelection');
    } catch (e) {
      print('Failed to load trans in provider: ${e.toString()}');
      _trans = [];
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchCars() async {
    print('Provider entered');
    isLoading = true;
    try {
      print(
          'getting cars for the year, brand, model and trans $selectedYear $selectedBrand $selectedModel $_selectedTrans');
      final response = await _carRepo.getCars(
          year: _selectedYear ?? 0,
          brand: _selectedBrand ?? '',
          model: _selectedModel ?? '',
          transmission: _selectedTrans ?? '');

      _cars = response;

      print('current selection: $currentSelection');
    } catch (e) {
      print('Failed to load cars in provider: ${e.toString()}');
      _trans = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
//else if (isCar) {
//       switch (currentSelection) {
//         case SelectionState.yearBrandModel:
//           _selectedTrans = null;
//           currentSelection = SelectionState.yearBrand;
//           break;
//         case SelectionState.yearBrand:
//           _selectedModel = null;
//           currentSelection = SelectionState.year;
//           break;
//         case SelectionState.year:
//           _selectedBrand = null;
//           currentSelection = SelectionState.none;
//           break;
//         case SelectionState.none:
//         default:
//           _selectedYear = null;
//           _selectedSubcategory = null;
//           subcategories = [];
//           break;
//       }
//       notifyListeners();
//     }

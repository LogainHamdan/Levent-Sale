import 'dart:io';

import 'package:Levant_Sale/src/modules/sections/repos/attributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

import '../../../../more/models/profile.dart';
import '../../../models/attriburtes.dart';
import '../../../repos/city.dart';

class UpdateAdSectionDetailsProvider extends ChangeNotifier {
  Map<String, String?> selectedValues = {};
  final List<File> _selectedImages = [];
  final Map<String, bool> _dropdownOpenedMap = {};
  final Map<int, bool> _services = {};
  final AdAttributesRepository _repo = AdAttributesRepository();
  final CityRepository cityRepo = CityRepository();
  AdAttributesModel? attributesData;
  bool hasError = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final Map<String, TextEditingController> dynamicFieldControllers = {};
  List<City> _cities = [];
  bool _isLoading = false;
  List<Governorate> _governorates = [];
  List<Governorate> get governorates => _governorates;
  List<City> get cities => _cities;
  bool get isLoading => _isLoading;
  List<File> get selectedImages => _selectedImages;
  final quill.QuillController _controller = quill.QuillController.basic();

  quill.QuillController get controller => _controller;

  Map<int, bool> get services => _services;

  void toggleService(int id, bool value) {
    _services[id] = value;
    notifyListeners();
  }

  bool getServiceValue(int id) {
    return _services[id] ?? false;
  }

  void setSelectedValue(String key, String? value) {
    selectedValues[key] = value;
    notifyListeners();
  }

  String? getSelectedValue(String key) {
    return selectedValues[key];
  }

  void setDropdownOpened(String key, bool value) {
    _dropdownOpenedMap[key] = value;
    notifyListeners();
  }

  bool isDropdownOpened(String key) => _dropdownOpenedMap[key] ?? false;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImages.add(File(pickedFile.path));
      notifyListeners();
    }
  }

  void removeImage(int index) {
    _selectedImages.removeAt(index);
    notifyListeners();
  }

  void clearImages() {
    _selectedImages.clear();
    notifyListeners();
  }

  TextEditingController getController(String key) {
    if (!dynamicFieldControllers.containsKey(key)) {
      dynamicFieldControllers[key] = TextEditingController();
    }
    return dynamicFieldControllers[key] ??
        TextEditingController(); // Safe fallback
  }

  Future<void> fetchAttributes(int categoryId) async {
    debugPrint('Fetching attributes for categoryId: $categoryId');

    try {
      final result = await _repo.getAttributesByCategory(categoryId);
      debugPrint('Result from API: $result');

      if (result != null) {
        attributesData = result;
        hasError = false;
        _services.clear();

        for (var detail in result.details ?? []) {
          if (detail.id != null) {
            _services[detail.id ?? 0] = false;
          }
        }
      } else {
        hasError = true;
        debugPrint('No result for categoryId: $categoryId');
      }

      notifyListeners();
    } catch (e) {
      hasError = true;
      debugPrint('Error in fetchAttributes: $e');
      notifyListeners(); // Ensure UI updates even on error
    }
  }

  Map<String, dynamic> getAttributeFieldsMap() {
    final Map<String, dynamic> attributesMap = {};
    final attributes = attributesData?.attributes;

    if (attributes == null || attributes.fields == null) return attributesMap;

    for (final field in attributes.fields!) {
      final name = field.name;

      if (name == null) continue;

      switch (field.type) {
        case FieldType.text:
        case FieldType.number:
          attributesMap[name] = getController(name).text;
          break;
        case FieldType.dropdown:
          attributesMap[name] = getSelectedValue(name);
          break;
        case FieldType.checkbox:
          attributesMap[name] = getSelectedValue(name) == 'false';
          break;
        default:
          attributesMap[name] = null;
      }
    }

    return attributesMap;
  }

  Future<void> loadCities({required int governorateId}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _cities = await cityRepo.getCities(governorateId: governorateId);
    } catch (e) {
      print('Error loading cities: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadGovernorates() async {
    _isLoading = true;
    notifyListeners();

    try {
      _governorates = await cityRepo.getGovernorates();
    } catch (e) {
      print('Error loading governorates: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

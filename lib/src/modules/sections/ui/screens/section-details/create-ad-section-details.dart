import 'dart:io';

import 'package:Levant_Sale/src/modules/sections/repos/attributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

import '../../../models/attriburtes.dart';

class CreateAdSectionDetailsProvider extends ChangeNotifier {
  Map<String, String?> selectedValues = {};
  final List<File> _selectedImages = [];
  final Map<String, bool> _dropdownOpenedMap = {};
  final Map<int, bool> _services = {};
  final AdAttributesRepository _repo = AdAttributesRepository();
  AdAttributesModel? attributesData;
  bool hasError = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

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

  Future<void> fetchAttributes(int categoryId) async {
    debugPrint('Fetching attributes for categoryId: $categoryId');

    try {
      final result = await _repo.getAttributesByCategory(categoryId);
      debugPrint('Result from API: $result');

      if (result != null) {
        attributesData = result;
        hasError = false;
        _services.clear();
        for (var detail in result.details) {
          _services[detail.id] = false;
        }
      } else {
        hasError = true;
        debugPrint('No result for categoryId: $categoryId');
      }

      notifyListeners();
    } catch (e) {
      hasError = true;
      debugPrint('Error in fetchAttributes: $e');
    }
  }
}

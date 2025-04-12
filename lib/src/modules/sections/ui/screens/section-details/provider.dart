import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

class SectionDetailsProvider extends ChangeNotifier {
  Map<String, String?> selectedValues = {};
  final List<File> _selectedImages = [];
  final Map<String, bool> _dropdownOpenedMap = {};

  List<File> get selectedImages => _selectedImages;
  bool hasElevator = false;
  bool hasParking = true;
  bool isDropdownOpened(String key) => _dropdownOpenedMap[key] ?? false;

  Map<String, bool> services = {
    "مسبح": false,
    "تكييف مركزي": true,
    "نظام تدفئة": true,
    "شرفة": false,
    "غرفة خادمة": false,
    "نظام أمان": false,
  };

  final quill.QuillController _controller = quill.QuillController.basic();

  quill.QuillController get controller => _controller;

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

  void toggleElevator(bool value) {
    hasElevator = value;
    notifyListeners();
  }

  void toggleParking(bool value) {
    hasParking = value;
    notifyListeners();
  }

  void toggleService(String key, bool value) {
    services[key] = value;
    notifyListeners();
  }

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
}

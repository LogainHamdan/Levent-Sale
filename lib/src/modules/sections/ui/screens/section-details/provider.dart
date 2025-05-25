import 'dart:io';

import 'package:Levant_Sale/src/modules/more/models/profile.dart';
import 'package:Levant_Sale/src/modules/sections/repos/attributes.dart';
import 'package:Levant_Sale/src/modules/sections/repos/city.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

import '../../../models/adDTO.dart';
import '../../../models/attriburtes.dart';

class CreateAdSectionDetailsProvider extends ChangeNotifier {
  Map<String, String?> selectedValues = {};
  final List<File> _selectedImages = [];
  String _mediaType = '';
  final Map<String, bool> _dropdownOpenedMap = {};
  final List<Detail> _selectedServices = [];
  final AdAttributesRepository _repo = AdAttributesRepository();
  final CityRepository cityRepo = CityRepository();
  bool _negotiable = false;
  bool _tradePossible = false;
  City? _selectedCity;
  Governorate? _selectedGovernorate;
  ContactMethod? _selectedContactMethod;
  AdAttributesModel? attributesData;
  bool hasError = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController contactDetailController = TextEditingController();
  final Map<String, TextEditingController> dynamicFieldControllers = {};
  List<City> _cities = [];
  AdType? _selectedAdType;
  bool _isLoading = false;
  List<Governorate> _governorates = [];
  bool get negotiable => _negotiable;
  bool get tradePossible => _tradePossible;
  String get mediaType => _mediaType;
  Currency? _selectedCurrency;

  Currency? get selectedCurrency => _selectedCurrency;

  AdType? get selectedAdType => _selectedAdType;

  List<Governorate> get governorates => _governorates;

  List<City> get cities => _cities;

  ContactMethod? get selectedContactMethod => _selectedContactMethod;

  bool get isLoading => _isLoading;

  List<File> get selectedImages => _selectedImages;
  final quill.QuillController _controller = quill.QuillController.basic();

  quill.QuillController get controller => _controller;

  City? get selectedCity => _selectedCity;

  Governorate? get selectedGovernorate => _selectedGovernorate;

  List<Detail> get selectedServices => _selectedServices;

  List<ContactMethod> numberMethods = [
    ContactMethod.CALL,
    ContactMethod.WHATSAPP,
    ContactMethod.SMS,
    ContactMethod.TELEGRAM,
  ];

  List<ContactMethod> emailMethods = [
    ContactMethod.EMAIL,
  ];

  List<ContactMethod> detailMethods = [
    ContactMethod.SITE_MESSAGES,
    ContactMethod.OTHER,
  ];
  void setNegotiable(bool value) {
    _negotiable = value;
    notifyListeners();
  }

  void setTradePossible(bool value) {
    _tradePossible = value;
    notifyListeners();
  }

  String getQuillText() {
    return _controller.document.toPlainText().trim();
  }

  void setSelectedAdType(AdType? type) {
    _selectedAdType = type;
    notifyListeners();
  }

  void setSelectedCity(City city) {
    _selectedCity = city;
    notifyListeners();
  }

  void setSelectedContactMethod(ContactMethod? method) {
    _selectedContactMethod = method;
    notifyListeners();
  }

  void setSelectedCurrency(String key, Currency? currency) {
    _selectedCurrency = currency;
    setSelectedValue(key, currency?.arabicName);
    notifyListeners();
  }

  void setSelectedGovernorate(Governorate governorate) {
    _selectedGovernorate = governorate;
    notifyListeners();
  }

  void resetSelections() {
    _selectedCity = null;
    _selectedGovernorate = null;
    notifyListeners();
  }

  void resetCity() {
    _selectedCity = null;
    _cities.clear();
    selectedValues.remove("city");

    dynamicFieldControllers.remove("city")?.clear();

    notifyListeners();
  }

  void toggleService(Detail detail, bool isSelected) {
    if (isSelected) {
      if (!_selectedServices.any((s) => s.id == detail.id)) {
        _selectedServices.add(detail);
      }
    } else {
      _selectedServices.removeWhere((s) => s.id == detail.id);
    }
    notifyListeners();
  }

  bool isServiceSelected(Detail detail) {
    return _selectedServices.any((s) => s.id == detail.id);
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
  set mediaType(String type) {
    _mediaType = type;
    notifyListeners();
  }
  void resetAttributes() {
    selectedValues.clear();

    for (var controller in dynamicFieldControllers.values) {
      controller.clear();
    }
    dynamicFieldControllers.clear();

    _selectedServices.clear();

    attributesData = null;

    notifyListeners();
  }

  Future<void> pickImage() async {
    print('media type: $_mediaType');
    final picker = ImagePicker();

    XFile? pickedFile;

    if (_mediaType == 'image') {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else if (_mediaType == 'video') {
      pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    }

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
    return dynamicFieldControllers[key] ?? TextEditingController();
  }

  Future<void> fetchAttributes(int categoryId) async {
    debugPrint('Fetching attributes for categoryId: $categoryId');

    try {
      final result = await _repo.getAttributesByCategory(categoryId);
      debugPrint('Result from API: $result');

      if (result != null) {
        attributesData = result;
        hasError = false;
        _selectedServices.clear();
      } else {
        hasError = true;
        debugPrint('No result for categoryId: $categoryId');
      }

      notifyListeners();
    } catch (e) {
      hasError = true;
      debugPrint('Error in fetchAttributes: $e');
      notifyListeners();
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
          if (attributesData?.details != null) {
            attributesMap[name] = _selectedServices.map((s) => s.id).toList();
          }
          break;
        case FieldType.radio:
          attributesMap[name] = getSelectedValue(name);
          break;
        default:
          attributesMap[name] = null;
      }
    }

    return attributesMap;
  }

  Currency? getSelectedCurrency(String key) {
    if (_selectedCurrency != null) return _selectedCurrency;

    final value = selectedValues[key];
    if (value != null) {
      return Currency.values.firstWhere(
        (e) => e.toString() == value,
        orElse: () => Currency.SYP,
      );
    }
    return null;
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

  bool validateFields1() {
    for (var controller in dynamicFieldControllers.values) {
      if (controller.text.trim().isEmpty) return false;
    }

    if (selectedValues.containsValue(null) ||
        selectedValues.containsValue("")) {
      return false;
    }
    return true;
  }

  bool validateFields2() {
    print('${selectedContactMethod?.name}');
    if (titleController.text.trim().isEmpty ||
        shortDescController.text.trim().isEmpty ||
        getQuillText().isEmpty ||
        priceController.text.trim().isEmpty ||
        contactDetailController.text.trim().isEmpty ||
        _selectedCity == null ||
        _selectedGovernorate == null ||
        _selectedAdType == null ||
        _selectedCurrency == null) {
      return false;
    }

    if (_selectedImages.isEmpty) return false;

    return true;
  }
}

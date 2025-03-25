import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;

class SectionDetailsProvider extends ChangeNotifier {
  String? selectedRooms;
  String? selectedBathrooms;
  String? selectedCondition;
  String? selectedAge;
  String? selectedFloor;
  String? selectedFurniture;
  String? selectedOwnership;
  bool hasElevator = false;
  bool hasParking = true;

  Map<String, bool> services = {
    "مسبح": false,
    "تكييف مركزي": true,
    "نظام تدفئة": true,
    "شرفة": false,
    "غرفة خادمة": false,
    "نظام أمان": false,
  };

  void setSelectedRooms(String value) {
    selectedRooms = value;
    notifyListeners();
  }

  // final quill.QuillController _controller = quill.QuillController.basic();
  //
  // quill.QuillController get controller => _controller;
  void setSelectedBathrooms(String value) {
    selectedBathrooms = value;
    notifyListeners();
  }

  void setSelectedCondition(String value) {
    selectedCondition = value;
    notifyListeners();
  }

  void setSelectedAge(String value) {
    selectedAge = value;
    notifyListeners();
  }

  void setSelectedFloor(String value) {
    selectedFloor = value;
    notifyListeners();
  }

  void setSelectedFurniture(String value) {
    selectedFurniture = value;
    notifyListeners();
  }

  void setSelectedOwnership(String value) {
    selectedOwnership = value;
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
}

import 'package:flutter/material.dart';

class DeleteProvider extends ChangeNotifier {
  int? _selectedReason;

  int? get selectedReason => _selectedReason;

  void selectReason(int index) {
    _selectedReason = index;
    notifyListeners();
  }
}

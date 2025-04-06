import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  bool _agreeToTerms = false;
  String _selectedValue = '';
  bool _isDropdownOpened = false;

  bool get agreeToTerms => _agreeToTerms;
  String get selectedValue => _selectedValue;
  bool get isDropdownOpened => _isDropdownOpened;

  void toggleAgreement(bool? value) {
    if (value != null) {
      _agreeToTerms = value;
      notifyListeners();
    }
  }

  void setSelectedValue(String? value) {
    if (value != null && _selectedValue != value) {
      _selectedValue = value;
      notifyListeners();
    }
  }

  void setDropdownOpened(bool value) {
    _isDropdownOpened = value;
    notifyListeners();
  }
}

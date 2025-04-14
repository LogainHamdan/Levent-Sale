import 'dart:io';

import 'package:flutter/material.dart';

import '../../../repos/ad.dart';

class UpdateAdProvider extends ChangeNotifier {
  final AdRepository _adRepository = AdRepository();

  int _currentStep = 3;
  final int _totalSteps = 4;

  int get currentStep => _currentStep;
  int get totalSteps => _totalSteps;

  void nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  bool isLastStep() => _currentStep == _totalSteps - 1;
}

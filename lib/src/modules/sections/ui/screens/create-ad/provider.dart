import 'dart:io';

import 'package:Levant_Sale/src/modules/sections/models/ad.dart';

import 'package:flutter/material.dart';
import '../../../repos/ad.dart';

class CreateAdProvider extends ChangeNotifier {
  final AdRepository _repo = AdRepository();

  int _currentStep = 0;
  final int _totalSteps = 4;
  bool isLoading = false;
  String? error;

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

  Future<void> createAd({
    required AdModel ad,
    required List<File> images,
    required String token,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _repo.createAd(ad: ad, images: images, token: token);
      isLoading = false;
      //
      // if (response.statusCode != 200 && response.statusCode != 201) {
      //   throw Exception(
      //       'Failed to create ad: ${response.statusCode} - ${response.data}');
      // }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }
}

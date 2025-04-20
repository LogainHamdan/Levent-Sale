import 'dart:io';

import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:dio/dio.dart';

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

  void resetProgress() {
    _currentStep = 0;
    isLoading = false;
    error = null;
    notifyListeners();
  }

  Future<void> createAd({
    required AdModel ad,
    required List<File> images,
    required String token,
  }) async {
    try {
      final response = await _repo.createAd(
        ad: ad,
        images: images,
        token: token,
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("AdCreatedSuccessfully");
      } else {
        print("AdCreatedFailed");
      }
    } catch (e) {
      print("AdCreatedFailed");
    }
  }
}

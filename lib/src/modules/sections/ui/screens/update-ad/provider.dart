import 'dart:io';

import 'package:Levant_Sale/src/modules/sections/models/ad.dart';

import 'package:flutter/material.dart';
import '../../../repos/ad.dart';

class UpdateAdProvider extends ChangeNotifier {
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

  Future<void> updateAd({
    required int adId,
    required AdModel adModel,
    required String token,
  }) async {
    try {
      final response = await _repo.updateAd(
        adId: adId,
        adModel: adModel,
        token: token,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
            'Failed to create ad: ${response.statusCode} - ${response.data}');
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }
}

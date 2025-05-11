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

  Future<Response> createAd({
    required AdModel adDTO,
    List<File>? files,
    required String token,
  }) async {
    try {
      print('ad to create: ${adDTO.toJson()}');
      final response = await _repo.createAd(
        adDTO: adDTO,
        files: files,
        token: token,
      );
      if (response.statusCode == 200) {
        print('ad created successfully: ${response.data}');
        return response;
      } else {
        print(
            'Failed to create ad. Status code: ${response.statusCode}, Response: ${response.data}');
        throw Exception('Failed to create ad');
      }
    } catch (e, stacktrace) {
      print("Ad Create Failed: $e");
      print("Stacktrace: $stacktrace");
      rethrow;
    }
  }
}

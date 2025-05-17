import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../../../../../config/constants.dart';
import '../../../models/adDTO.dart';
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

  void resetProgress() {
    _currentStep = 0;
    isLoading = false;
    error = null;
    notifyListeners();
  }

  Future<Response?> createAd({
    required AdDTO adDTO,
    List<File>? files,
    required String token,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      print('to create provider');

      final response =
          await _repo.createAd(adDTO: adDTO, files: files, token: token);
      isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
      return null;
    }
  }
}

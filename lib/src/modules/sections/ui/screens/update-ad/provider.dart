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
  AdModel? _selectedAdToUpdate;

  int _currentStep = 3;
  final int _totalSteps = 4;
  bool isLoading = false;
  String? error;
  AdModel? get selectedAdToUpdate => _selectedAdToUpdate;

  int get currentStep => _currentStep;

  int get totalSteps => _totalSteps;
  void selectAdToUpdate(AdModel ad) {
    _selectedAdToUpdate = ad;
    notifyListeners();
  }

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

  Future<Response?> updateAd(
    AdDTO adDTO,
    List<dynamic>? files, {
    required int id,
    required String token,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await _repo.updateAd(adDTO, files, token: token, id: id);
      if (response.statusCode == 200) {
        print('update successfully 200 : ${adDTO.toJson()}');
      }
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

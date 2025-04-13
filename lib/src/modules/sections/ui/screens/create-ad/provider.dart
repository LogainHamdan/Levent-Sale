import 'dart:io';

import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repos/create-ad.dart';
import '../choose-section/create-ad-choose-section-provider.dart';
import '../section-details/create-ad-section-details.dart';

class CreateAdProvider extends ChangeNotifier {
  final AdRepository _adRepository = AdRepository();

  int _currentStep = 0;
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

  Future<void> createAd(String token, BuildContext context) async {
    final sectionDetailsProvider =
        Provider.of<CreateAdSectionDetailsProvider>(context, listen: false);
    final chooseSectionProvider =
        Provider.of<CreateAdChooseSectionProvider>(context, listen: false);

    final adDTO = {
      "title": sectionDetailsProvider.getSelectedValue("العنوان") ??
          "عنوان بدون اسم",
      "categoryPath": '',
      "categoryNamePath": "",
      "description": sectionDetailsProvider.getSelectedValue("الوصف") ?? "",
      "longDescription":
          sectionDetailsProvider.controller.document.toPlainText().trim(),
      "tradePossible": false,
      "negotiable": true,
      "contactPhone":
          sectionDetailsProvider.getSelectedValue("رقم الهاتف") ?? "",
      "contactEmail": sectionDetailsProvider.getSelectedValue("الايميل") ?? "",
      "userId": 1,
      "price":
          int.parse(sectionDetailsProvider.getSelectedValue("السعر") ?? "0") ??
              0,
      "governorate": sectionDetailsProvider.getSelectedValue("المحافظة") ?? "",
      "city": sectionDetailsProvider.getSelectedValue("المدينة") ?? "",
      "fullAddress":
          sectionDetailsProvider.getSelectedValue("العنوان الكامل") ?? "",
      "adType": "NEW",
      "preferredContactMethod": "CALL",
      "condition": "PUBLISHED",
      "currency": "SYP",
      "attributes": {
        "services": sectionDetailsProvider.services,
        "elevator": sectionDetailsProvider.hasElevator,
        "parking": sectionDetailsProvider.hasParking,
      },
    };

    try {
      final response = await _adRepository.createAd(
        token: token,
        adDTO: adDTO,
        files: sectionDetailsProvider.selectedImages,
      );

      if (response.statusCode == 200) {
        debugPrint("تم إنشاء الإعلان بنجاح");
      } else {
        debugPrint("فشل إنشاء الإعلان ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}

import 'dart:io';

import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repos/create-ad.dart';
import '../choose-section/choose-section-provider.dart';
import '../section-details/provider.dart';

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
    final sectionProvider =
        Provider.of<SectionDetailsProvider>(context, listen: false);
    final categoryProvider =
        Provider.of<ChoosesSectionProvider>(context, listen: false);

    final adDTO = {
      "title": sectionProvider.getSelectedValue("العنوان") ?? "عنوان بدون اسم",
      "categoryPath": "main/${categoryProvider.selectedCategoryIndex}",
      "categoryNamePath": "",
      "description": sectionProvider.getSelectedValue("الوصف") ?? "",
      "longDescription":
          sectionProvider.controller.document.toPlainText().trim(),
      "tradePossible": false,
      "negotiable": true,
      "contactPhone": sectionProvider.getSelectedValue("رقم الهاتف") ?? "",
      "contactEmail": sectionProvider.getSelectedValue("الايميل") ?? "",
      "userId": 1,
      "price": int.parse(sectionProvider.getSelectedValue("السعر") ?? "0") ?? 0,
      "governorate": sectionProvider.getSelectedValue("المحافظة") ?? "",
      "city": sectionProvider.getSelectedValue("المدينة") ?? "",
      "fullAddress": sectionProvider.getSelectedValue("العنوان الكامل") ?? "",
      "adType": "NEW",
      "preferredContactMethod": "CALL",
      "condition": "PUBLISHED",
      "currency": "SYP",
      "attributes": {
        "services": sectionProvider.services,
        "elevator": sectionProvider.hasElevator,
        "parking": sectionProvider.hasParking,
      },
    };

    try {
      final response = await _adRepository.createAd(
        token: token,
        adDTO: adDTO,
        files: sectionProvider.selectedImages,
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

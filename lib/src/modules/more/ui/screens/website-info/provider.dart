import 'package:flutter/material.dart';

import '../../../repositories/website-info.dart';

class WebsiteInfoProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  int get currentIndex => _currentIndex;

  void changeTab(int index) {
    _currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final WebsiteInfoRepository _repository = WebsiteInfoRepository();

  String? aboutUs;
  String? terms;
  String? privacyPolicy;
  bool isLoading = false;
  String? error;

  Future<void> loadAboutUs() async {
    isLoading = true;
    error = null;

    try {
      aboutUs = await _repository.getAboutUs();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadTerms() async {
    isLoading = true;
    error = null;

    try {
      terms = await _repository.getTerms();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadPrivacyPolicy() async {
    isLoading = true;
    error = null;

    try {
      privacyPolicy = await _repository.getPrivacyPolicy();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  // Future<void> loadAllWebsiteInfo() async {
  //   isLoading = true;
  //   error = null;
  //   notifyListeners();
  //
  //   try {
  //     final results = await Future.wait([
  //       _repository.getAboutUs(),
  //       _repository.getTerms(),
  //       _repository.getPrivacyPolicy(),
  //     ]);
  //     aboutUs = results[0];
  //     terms = results[1];
  //     privacyPolicy = results[2];
  //   } catch (e) {
  //     error = e.toString();
  //   }
  //
  //   isLoading = false;
  //   notifyListeners();
  // }
}

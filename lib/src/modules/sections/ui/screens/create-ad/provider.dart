import 'package:flutter/material.dart';

//
// class StepperProvider with ChangeNotifier {
//   int _currentStep = 0;
//   final int totalSteps = 4;
//
//   int get currentStep => _currentStep;
//
//   void nextStep() {
//     if (_currentStep < totalSteps - 1) {
//       _currentStep++;
//       print("Step changed: $_currentStep");
//       notifyListeners();
//     }
//   }
//
//   void previousStep() {
//     if (_currentStep > 0) {
//       _currentStep--;
//       notifyListeners();
//     }
//   }
// }
class StepperProvider extends ChangeNotifier {
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
}

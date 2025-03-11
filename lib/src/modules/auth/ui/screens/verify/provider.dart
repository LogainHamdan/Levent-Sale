import 'package:flutter/material.dart';

import '../login/login.dart';

class VerificationProvider extends ChangeNotifier {
  List<String> otp = List.generate(6, (index) => '0');
  int selectedIndex = -1;

  List<String> getOtp() => otp;

  void updateOtp(String value, int index) {
    if (index >= 0 && index < otp.length) {
      otp[index] = value.isEmpty ? '0' : value;
      notifyListeners();
    }
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void submitOtpAction(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }
}

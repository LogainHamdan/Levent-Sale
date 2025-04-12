import 'package:Levant_Sale/src/modules/main/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';

import '../../../repos/auth-repo.dart';

class VerificationProvider extends ChangeNotifier {
  List<String> otp = List.generate(6, (index) => '0');
  int selectedIndex = -1;
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  String? _message;

  bool get isLoading => _isLoading;
  String? get message => _message;
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
    Navigator.pushNamed(context, MainScreen.id);
  }

  Future<bool> verifyToken(String token) async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    try {
      final response = await _authRepository.verifyToken(token);
      if (response.statusCode == 200) {
        _message = response.data.toString();
        return true;
      } else {
        _message = 'فشل التحقق: ${response.statusCode}';
        return false;
      }
    } catch (e) {
      _message = 'حدث خطأ أثناء التحقق: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resendVerify(String email) async {
    notifyListeners();

    try {
      final response = await _authRepository.resendVerificationCode(email);
      if (response.statusCode == 200) {
        print("Verification code sent successfully");
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}

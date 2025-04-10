import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/repos/google-login-repo.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/repos/login-repo.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/repos/logout-repo.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/repos/request-change-pass.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../main/ui/screens/main_screen.dart';

class AuthProvider extends ChangeNotifier {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _rememberMe = false;
  String? _errorMessage;
  bool _isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailRequestController = TextEditingController();

  final GoogleLoginRepository _googleAuthRepository = GoogleLoginRepository();
  final LoginRepository _loginRepository = LoginRepository();
  final LogoutRepository _logoutRepository = LogoutRepository();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final PasswordResetRepository _passwordResetRepository =
      PasswordResetRepository();

  bool get passwordVisible => _passwordVisible;
  bool get confirmPasswordVisible => _confirmPasswordVisible;
  bool get rememberMe => _rememberMe;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  bool _isFormValid = false;

  bool get isFormValid => _isFormValid;

  void setFormValid(bool isValid) {
    _isFormValid = isValid;
    notifyListeners();
  }

  void togglePasswordVisibility({required bool isConfirmField}) {
    if (isConfirmField) {
      _confirmPasswordVisible = !_confirmPasswordVisible;
    } else {
      _passwordVisible = !_passwordVisible;
    }
    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    if (value != null) {
      _rememberMe = value;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> logoutUser(BuildContext context) async {
    _setLoading(true);

    try {
      await _logoutRepository.logoutUser();
      _setLoading(false);
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.id,
        (route) => false,
      );
    } catch (e) {
      _setLoading(false);
      _setErrorMessage(e.toString());
    }
  }

  Future<void> loginUser({
    required BuildContext context,
    required String identifier,
    required String password,
    required String recaptchaToken,
  }) async {
    _setLoading(true);

    if (identifier.isEmpty || password.isEmpty) {
      _setLoading(false);
      _setErrorMessage('الرجاء ملء جميع الحقول.');
      return;
    }

    try {
      final result = await _loginRepository.loginUser(
        identifier: identifier,
        password: password,
        recaptchaToken: recaptchaToken,
      );

      if (result['statusCode'] == 200) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainScreen.id,
          (route) => false,
        );
      } else {
        _setErrorMessage(result['error'] ?? 'فشل تسجيل الدخول');
      }
    } catch (e) {
      _setErrorMessage('فشل تسجيل الدخول: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> googleLogin(BuildContext context) async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _setLoading(false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? token = googleAuth.idToken;

      if (token == null) {
        throw Exception('Failed to get token');
      }

      final result = await _googleAuthRepository.googleLogin(token);

      if (result['statusCode'] == 200) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainScreen.id,
          (route) => false,
        );
      } else {
        _setErrorMessage(result['error'] ?? 'Google login failed');
      }

      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      _setErrorMessage('Google login failed: ${e.toString()}');
    }
  }

  Future<void> requestPasswordReset(String email) async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      final response =
          await _passwordResetRepository.requestPasswordReset(email);

      if (response.statusCode == 200) {
        debugPrint("Password reset email sent.");
      } else {
        _setErrorMessage("Failed to send reset email: ${response.statusCode}");
      }
    } catch (e) {
      _setErrorMessage("$e");
    } finally {
      _setLoading(false);
    }
  }
}

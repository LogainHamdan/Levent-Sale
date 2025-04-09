import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/repos/google-login-repo.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/repos/login-repo.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/repos/logout-repo.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../main/ui/screens/main_screen.dart';

class AuthProvider extends ChangeNotifier {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _rememberMe = false;
  String? _errorMessage;
  bool _isLoading = false;
  final GoogleLoginRepository _googleAuthRepository;
  final LoginRepository _loginRepository;
  final LogoutRepository _logoutRepository;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthProvider({
    required GoogleLoginRepository googleAuthRepository,
    required LoginRepository loginRepository,
    required LogoutRepository logoutRepository,
  })  : _googleAuthRepository = googleAuthRepository,
        _loginRepository = loginRepository,
        _logoutRepository = logoutRepository;

  bool get passwordVisible => _passwordVisible;
  bool get confirmPasswordVisible => _confirmPasswordVisible;
  bool get rememberMe => _rememberMe;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

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
    _isLoading = true;
    notifyListeners();

    try {
      await _logoutRepository.logoutUser();
      _isLoading = false;
      notifyListeners();
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.id, (route) => false);
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> loginUser({
    required BuildContext context,
    required String idmitFile,
    required String password,
    required String trustChainBase,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (idmitFile.isEmpty || password.isEmpty) {
      _isLoading = false;
      _errorMessage = 'الرجاء ملء جميع الحقول.';
      notifyListeners();
      return;
    }

    try {
      final result = await _loginRepository.loginUser(
        idmitfile: idmitFile,
        password: password,
        trustchainbase: trustChainBase,
      );

      _isLoading = false;

      if (result['success'] == true) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainScreen.id,
          (route) => false,
        );
      } else {
        _errorMessage = result['error'] ?? 'فشل تسجيل الدخول';
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'فشل تسجيل الدخول: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> googleLogin(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? token = googleAuth.idToken;

      if (token == null) {
        throw Exception('Failed to get Google ID token');
      }

      final result = await _googleAuthRepository.googleLogin(token);
      _isLoading = false;

      if (result['success'] == true) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainScreen.id,
          (route) => false,
        );
      } else {
        _errorMessage = result['error'] ?? 'Google login failed';
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Google login failed: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }
}

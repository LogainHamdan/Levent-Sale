import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main/ui/screens/main_screen.dart';
import '../../../repos/auth-repo.dart';
import '../../../repos/token-helper.dart';

class AuthProvider extends ChangeNotifier {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _rememberMe = false;
  String? _errorMessage;
  bool _isLoading = false;
  Map<String, dynamic>? _currentUser;
  Map<String, dynamic>? get currentUser => _currentUser;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailRequestController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final AuthRepository _authRepository = AuthRepository();

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
      await _authRepository.logoutUser();
      _currentUser = null;
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

  Future<void> checkIfLoggedIn(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      try {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainScreen.id,
          (route) => false,
        );
      } catch (e) {
        await prefs.clear();
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.id,
          (route) => false,
        );
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.id,
        (route) => false,
      );
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }

  Future<void> loginUser({
    required BuildContext context,
    required String identifier,
    required String password,
    String? recaptchaToken,
  }) async {
    _setLoading(true);

    if (identifier.isEmpty || password.isEmpty) {
      _setLoading(false);
      _setErrorMessage('الرجاء ملء جميع الحقول.');
      return;
    }

    try {
      final result = await _authRepository.loginUser(
        identifier: identifier,
        password: password,
      );
      print(result['statusCode']);
      if (result.containsKey('error')) {
        print("LOGIN ERROR: ${result['error']}");
        _setErrorMessage(result['error'] ?? 'حدث خطأ غير متوقع.');
        return;
      } else {
        print("LOGIN SUCCESS: ${result['data']}");
      }

      if (result['statusCode'] == 200) {
        if (result['data'].isEmpty) {
          print("Warning: No data returned from server");
          _setErrorMessage('التسجيل لم يتم بنجاح، الاستجابة فارغة.');
          return;
        }

        notifyListeners();
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
      print("Attempting Google Sign-In...");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print("Google user: $googleUser");

      if (googleUser == null) {
        _setLoading(false);
        print("Google login canceled by user");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? token = googleAuth.idToken;
      print("Token: $token");

      if (token == null) {
        throw Exception('Failed to get token');
      }

      print("Making API call with token: $token");
      final result = await _authRepository.googleLogin(token);
      print("API result: $result");

      if (result['statusCode'] == 200) {
        print("Google login successful");

        Navigator.pushNamedAndRemoveUntil(
          context,
          MainScreen.id,
          (route) => false,
        );
      } else {
        print("Error: ${result['error']}");

        _setErrorMessage(result['error'] ?? 'Google login failed');
      }
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      _setErrorMessage('Google login failed: ${e.toString()}');

      print("Error: $e");
    }
  }

  Future<void> requestPasswordReset(String email) async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      final response = await _authRepository.requestPasswordReset(email);

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

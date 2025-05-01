import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main/ui/screens/main_screen.dart';
import '../../../models/user.dart';
import '../../../repos/auth-repo.dart';
import '../../../repos/token-helper.dart';
import '../../../repos/user-helper.dart';

class LoginProvider extends ChangeNotifier {
  bool hasTriedSubmit = false;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _rememberMe = false;
  String? _errorMessage;
  bool _isLoading = false;

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
  void markTriedSubmit() {
    hasTriedSubmit = true;
    notifyListeners();
  }

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

  String? validateCheckbox(bool value) {
    return value ? null : 'تذكرني';
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
      var response = await _authRepository.logoutUser();

      if (response.statusCode == 200) {
        await TokenHelper.removeToken();
        await UserHelper.removeUser();

        _setLoading(false);
        print('Logout successful');
      } else {
        _setLoading(false);
        _setErrorMessage(' Logout failed: ${response.statusCode}');
      }
    } catch (e) {
      _setLoading(false);
      _setErrorMessage(e.toString());
      print('$e');
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
  }) async {
    _setLoading(true);

    if (identifier.isEmpty || password.isEmpty) {
      _setLoading(false);
      _setErrorMessage('الرجاء ملء جميع الحقول.');
      await TokenHelper.removeToken();
      return;
    }

    try {
      final result = await _authRepository.loginUser(
        identifier: identifier,
        password: password,
      );

      print(result['statusCode']);

      if (result['statusCode'] == 200) {
        final token = result['token'];
        final userData = result['user'];
        if (token == null) {
          print('التوكن غير موجود.');
          await TokenHelper.removeToken();
          return;
        }

        await TokenHelper.saveToken(token);
        await UserHelper.saveUser(User.fromJson(userData));
        print('Token saved: $token');
        print('Login result: $result');
        notifyListeners();
      } else {
        await TokenHelper.removeToken();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('الحساب غير مفعل أو خطأ في البيانات'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      await TokenHelper.removeToken();
      print('فشل تسجيل الدخول: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<User?> getUserById({required int id, required String token}) async {
    try {
      final userData = await _authRepository.getUserById(id: id, token: token);
      return userData;
    } catch (e) {
      return null;
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
      print("1. Attempting Google Sign-In...");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print("2. Google user received: $googleUser");

      if (googleUser == null) {
        print("2a. Google login canceled by user");
        _setLoading(false);
        _setErrorMessage("Google login canceled. Please try again.");
        return;
      }

      print("3. Getting authentication...");
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print("4. Authentication received");
      final String? token = googleAuth.idToken;
      print("5. Token retrieved: ${token != null ? 'yes' : 'no'}");
    } catch (e) {
      print("Error in googleLogin: $e");

      if (e is DioException) {
        _setErrorMessage('Network error occurred: ${e.message}');
      } else if (e.toString().contains("Failed to retrieve Google ID token")) {
        _setErrorMessage('Failed to retrieve token. Please try again.');
      } else {
        _setErrorMessage('An unexpected error occurred: ${e.toString()}');
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> requestPasswordReset(String email) async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      final response = await _authRepository.requestPasswordReset(email);
      print(response.statusCode);
      if (response.statusCode == 200) {
        debugPrint("Password reset email sent.");
      } else {
        _setErrorMessage("Failed to send reset email: ${response.statusCode}");
      }
    } catch (e) {
      _setErrorMessage("Error: $e");
    } finally {
      _setLoading(false);
    }
  }
}

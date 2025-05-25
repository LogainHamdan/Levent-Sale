import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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
  String? passwordError;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailRequestController = TextEditingController();

  final AuthRepository _authRepository = AuthRepository();

  bool get passwordVisible => _passwordVisible;
  bool get confirmPasswordVisible => _confirmPasswordVisible;
  bool get rememberMe => _rememberMe;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  bool _isFormValid = false;

  bool get isFormValid => _isFormValid;
  LoginProvider() {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': 'LoginScreen',
      },
    );
    initializeRememberedCredentials();
  }

  void initializeRememberedCredentials() async {
    try {
      final rememberedUser = await UserHelper.getRememberedUser();
      print('Remembered user in login: $rememberedUser');

      if (rememberedUser != null) {
        emailController.text = rememberedUser.email ?? '';
        passwordController.text = rememberedUser.password ?? '';
        _rememberMe = await UserHelper.getRememberMeStatus();
        print('remember me status: $_rememberMe');
        print('Remember Me status: $_rememberMe');
      }
      notifyListeners();
    } catch (e) {
      print('Error retrieving remembered credentials: $e');
    }
  }

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

  void validateFields() {
    passwordError = validatePassword(passwordController.text);
    _isFormValid = passwordError == null;
    notifyListeners();
  }

  String? validatePassword(String value) {
    if (value.isEmpty) return 'يرجى إدخال كلمة المرور';
    if (value.length < 8) return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
    return null;
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
  //
  // Future<void> logoutUser(BuildContext context, {required String token}) async {
  //   _setLoading(true);
  //
  //   try {
  //     var response = await _authRepository.logoutUser(token: token);
  //
  //     if (response.statusCode == 200) {
  //       await TokenHelper.removeToken();
  //
  //       await UserHelper.removeUser();
  //       // await UserHelper.removeRememberMeStatus();
  //
  //       _setLoading(false);
  //       print('Logout successful');
  //     } else {
  //       _setLoading(false);
  //       _setErrorMessage(' Logout failed: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     _setLoading(false);
  //     _setErrorMessage(e.toString());
  //     print('$e');
  //   }
  // }

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

  Future<User?> getUserById({required int id}) async {
    try {
      final userData = await _authRepository.getUserById(id: id);
      notifyListeners();

      return userData;
    } catch (e) {
      notifyListeners();

      return null;
    }
  }

  Future<void> requestPasswordReset({required String email}) async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      final response = await _authRepository.requestPasswordReset(email: email);
      print(response.statusCode);
      if (response.statusCode == 200) {
        debugPrint("Password reset email sent.");
      } else {
        _setErrorMessage("Failed to send reset email: ${response.statusCode}");
      }
    } catch (e) {
      _setErrorMessage("Error: $e");
      print(e.toString());
    } finally {
      _setLoading(false);
    }
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
      if (result['statusCode'] == 200) {
        final token = result['token'];
        final userData = result['user'];
        if (token == null) {
          print('التوكن غير موجود.');
          await TokenHelper.removeToken();
          return;
        }

        await TokenHelper.saveToken(token);
        if (_rememberMe)
          await UserHelper.saveUserWithRememberMe(
            User.fromJson(userData),
            _rememberMe,
          );

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
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile',"openid"],

  );

  Future<void> handleGoogleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      final auth = await account?.authentication;

      print('Access Token: ${auth?.accessToken}');
      print('ID Token: ${auth?.idToken}');
      googleLogin(auth?.idToken??"");

    } catch (error) {
      print('Google sign-in failed: $error');
    }
  }
  Future<void> googleLogin(String token) async {

    try {

      final response = await _authRepository.googleLogin(token);
      if (response.statusCode == 200) {
        await TokenHelper.saveToken(token);
        print("Google login successful: ${response.data}");
      } else {
        print("Failed to login: ${response.statusCode}");
        throw Exception("Failed to login");
      }
    } catch (e) {
      print("Error during Google login: $e");
      throw Exception("Google login failed");
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> checkRememberMeStatus() async {
    final rememberMeStatus = await UserHelper.getRememberMeStatus();
    _rememberMe = rememberMeStatus;
    notifyListeners();
  }
}

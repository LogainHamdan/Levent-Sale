import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/auth/repos/auth-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../verify/verify.dart';

class SignUpProvider extends ChangeNotifier {
  bool isLoading = false;
  bool hasTriedSubmit = false;

  String? errorMessage;
  final TextEditingController birthDateController = TextEditingController(
      text: DateFormat('MMMM dd, yyyy').format(DateTime.now()).toString());
  final TextEditingController companyDateController = TextEditingController(
      text: DateFormat('MMMM dd, yyyy').format(DateTime.now()).toString());

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final companyNameController = TextEditingController();
  final companyAddressController = TextEditingController();
  final taxNumberController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  String? emailError,
      passwordError,
      confirmPasswordError,
      phoneError,
      checkboxError;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    birthDateController.dispose();
    companyNameController.dispose();
    companyDateController.dispose();
    companyAddressController.dispose();
    taxNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  bool _agreeToTerms = false;
  String _selectedValue = '';
  bool _isDropdownOpened = false;
  final AuthRepository _authRepository = AuthRepository();

  bool get agreeToTerms => _agreeToTerms;

  bool get isDropdownOpened => _isDropdownOpened;

  String get selectedValue => _selectedValue;
  void validatePasswordOnChange(String value) {
    passwordError = validatePassword(value);
    notifyListeners();
  }

  void validateConfirmPasswordOnChange(String value) {
    confirmPasswordError =
        validateConfirmPassword(value, passwordController.text);
    notifyListeners();
  }

  void markTriedSubmit() {
    hasTriedSubmit = true;
    notifyListeners();
  }

  void toggleAgreement(bool? value) {
    if (value != null) {
      _agreeToTerms = value;
      checkboxError =
          _agreeToTerms ? null : 'يجب الموافقة على الشروط والخصوصية';
      notifyListeners();
    }
  }

  String? get checkboxErrorText {
    if (hasTriedSubmit && !_agreeToTerms) {
      return 'يجب الموافقة على الشروط والخصوصية';
    }
    return null;
  }

  void setSelectedValue(String? value) {
    if (value != null) {
      _selectedValue = value;
      notifyListeners();
    }
  }

  void validateFields() {
    emailError = validateEmail(emailController.text);
    passwordError = validatePassword(passwordController.text);
    confirmPasswordError = validateConfirmPassword(
      confirmPasswordController.text,
      passwordController.text,
    );
    phoneError = validatePhone(phoneController.text);
    checkboxError = validateCheckbox(agreeToTerms);

    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value) ? null : 'البريد الإلكتروني غير صالح';
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال كلمة المرور';
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    return passwordRegex.hasMatch(value)
        ? null
        : 'كلمة المرور يجب أن تكون 8 أحرف على الأقل وتحتوي على حرف كبير، رقم، ورمز خاص';
  }

  String? validateConfirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'يرجى تأكيد كلمة المرور';
    return value == original ? null : 'كلمتا المرور غير متطابقتين';
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال رقم الهاتف';
    final phoneRegex = RegExp(r'^\+963\d{9}$');
    return phoneRegex.hasMatch(value)
        ? null
        : 'رقم الهاتف هنا يجب أن يتكون من 9 أرقام';
  }

  String? validateCheckbox(bool value) {
    return value ? null : 'يجب الموافقة على الشروط';
  }

  Future<bool> signUpUser(
      BuildContext context, Map<String, dynamic> userData) async {
    isLoading = true;
    notifyListeners();
    print("User Data: $userData");
    try {
      Response response;

      if (_selectedValue == 'شركة') {
        final owner = User(
          email: userData['email'],
          password: userData['password'],
          phoneNumber: userData['phone'],
          firstName: userData['first_name'],
          lastName: userData['last_name'],
          businessName: userData['company_name'],
          businessLicense: userData['tax_number'],
          birthday: userData['birth_date'] != null
              ? DateFormat('MMMM d, yyyy').parse(userData['birth_date'])
              : null,
          roles: ['business_owner'],
        );

        print('SIGNING UP BUSINESS: ${owner.toJson()}');

        response = await _authRepository.signUp(owner);
      } else if (_selectedValue == 'شخصي') {
        final account = User(
          email: userData['email'],
          password: userData['password'],
          phoneNumber: userData['phone'],
          firstName: userData['first_name'],
          lastName: userData['last_name'],
          birthday: userData['birth_date'] != null
              ? DateFormat('MMMM d, yyyy').parse(userData['birth_date'])
              : null,
          roles: ['personal_user'],
        );

        print('SIGNING UP PERSONAL: ${account.toJson()}');

        response = await _authRepository.signUp(account);
        print('STATUS CODE:${response.statusCode}');
      } else {
        customShowSnackBar(context, 'يرجى اختيار نوع الحساب', Colors.redAccent);
        return false;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        customShowSnackBar(
          context,
          'فشل التسجيل: ${response.statusMessage}',
          Colors.redAccent,
        );
        return false;
      }
    } catch (e) {
      if (e is DioException) {
        print('SIGN UP ERROR: ${e.message}');
        print('RESPONSE DATA: ${e.response?.data}');
        print('STATUS CODE: ${e.response?.statusCode}');
      } else {
        print('ERROR: $e');
      }
      print(e.toString());
      customShowSnackBar(
        context,
        'حدث خطأ أثناء التسجيل',
        Colors.redAccent,
      );
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setDropdownOpened(bool value) {
    _isDropdownOpened = value;
    notifyListeners();
  }

  void customShowSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

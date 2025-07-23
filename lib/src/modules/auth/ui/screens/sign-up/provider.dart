// signup_provider.dart
import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/auth/repos/auth-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpProvider extends ChangeNotifier {
  // Loading state
  bool isLoading = false;
  bool hasTriedSubmit = false;

  // Controllers
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController companyDateController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Error messages
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? phoneError;
  String? checkboxError;

  // Form state
  bool _agreeToTerms = false;
  String _selectedValue = 'شخصي';
  bool _isDropdownOpened = false;

  // Repository
  final AuthRepository _authRepository = AuthRepository();

  // Constants
  static const String _personalAccount = 'شخصي';
  static const String _companyAccount = 'شركة';
  static const String _dateFormat = 'MMMM dd, yyyy';
  static const String _phonePrefix = '+963';

  // Constructor
  SignUpProvider() {
    _initializeDateControllers();
  }

  // Getters
  bool get agreeToTerms => _agreeToTerms;
  bool get isDropdownOpened => _isDropdownOpened;
  String get selectedValue => _selectedValue;
  bool get isPersonalAccount => _selectedValue == _personalAccount;
  bool get isCompanyAccount => _selectedValue == _companyAccount;

  String? get checkboxErrorText {
    if (hasTriedSubmit && !_agreeToTerms) {
      return 'يجب الموافقة على الشروط والخصوصية';
    }
    return null;
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  // Initialization
  void _initializeDateControllers() {
    final currentDate = DateFormat(_dateFormat).format(DateTime.now());
    birthDateController.text = currentDate;
    companyDateController.text = currentDate;
  }

  void _disposeControllers() {
    firstNameController.dispose();
    lastNameController.dispose();
    birthDateController.dispose();
    companyNameController.dispose();
    companyDateController.dispose();
    taxNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
  }

  // Validation methods
  void validatePasswordOnChange(String value) {
    passwordError = _validatePassword(value);
    notifyListeners();
  }

  void validateConfirmPasswordOnChange(String value) {
    confirmPasswordError = _validateConfirmPassword(value, passwordController.text);
    notifyListeners();
  }

  bool validateAllFields() {
    emailError = _validateEmail(emailController.text);
    passwordError = _validatePassword(passwordController.text);
    confirmPasswordError = _validateConfirmPassword(
      confirmPasswordController.text,
      passwordController.text,
    );
    phoneError = _validatePhone(phoneController.text);
    checkboxError = _validateCheckbox(agreeToTerms);

    notifyListeners();

    return emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        phoneError == null &&
        checkboxError == null;
  }

  String? getFieldError(String fieldKey) {
    if (!hasTriedSubmit) return null;

    switch (fieldKey) {
      case 'firstName':
        return firstNameController.text.trim().isEmpty ? 'مطلوب' : null;
      case 'lastName':
        return lastNameController.text.trim().isEmpty ? 'مطلوب' : null;
      case 'birthDate':
        return birthDateController.text.trim().isEmpty
            ? 'يجب عليك إدخال تاريخ ميلاد صحيح' : null;
      case 'companyName':
        return companyNameController.text.trim().isEmpty ? 'مطلوب' : null;
      case 'companyDate':
        return companyDateController.text.trim().isEmpty ? 'مطلوب' : null;
      default:
        return null;
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'البريد الإلكتروني غير صالح';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }

    if (value.length < 8) {
      return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
    }

    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'كلمة المرور يجب أن تحتوي على حرف كبير، رقم، ورمز خاص';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }

    if (value != original) {
      return 'كلمتا المرور غير متطابقتين';
    }

    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    }

    final cleanPhone = value.trim().replaceAll(RegExp(r'\D'), '');

    if (cleanPhone.length < 9 || cleanPhone.length > 15) {
      return 'رقم الهاتف يجب أن يتكون من 9-15 رقم';
    }

    return null;
  }

  String? _validateCheckbox(bool value) {
    return value ? null : 'يجب الموافقة على الشروط';
  }

  // State management
  void markTriedSubmit() {
    hasTriedSubmit = true;
    notifyListeners();
  }

  void toggleAgreement(bool? value) {
    if (value != null) {
      _agreeToTerms = value;
      checkboxError = _agreeToTerms ? null : 'يجب الموافقة على الشروط والخصوصية';
      notifyListeners();
    }
  }

  void setSelectedValue(String? value) {
    if (value != null && value != _selectedValue) {
      _selectedValue = value;
      _clearFieldsOnAccountTypeChange();
      notifyListeners();
    }
  }

  void setDropdownOpened(bool value) {
    _isDropdownOpened = value;
    notifyListeners();
  }

  void _clearFieldsOnAccountTypeChange() {
    // Clear specific fields when switching account types
    if (isPersonalAccount) {
      companyNameController.clear();
      companyDateController.text = DateFormat(_dateFormat).format(DateTime.now());
      taxNumberController.clear();
    } else {
      firstNameController.clear();
      lastNameController.clear();
      birthDateController.text = DateFormat(_dateFormat).format(DateTime.now());
    }
  }

  // Data building
  Map<String, dynamic> buildUserData() {
    final baseData = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "phone": phoneController.text.trim(),
      "role": _selectedValue,
    };

    if (isCompanyAccount) {
      baseData.addAll({
        "company_name": companyNameController.text.trim(),
        "company_date": companyDateController.text.trim(),
        "tax_number": taxNumberController.text.trim(),
      });
    } else {
      baseData.addAll({
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
        "birth_date": birthDateController.text.trim(),
      });
    }

    return baseData;
  }

  bool validateRequiredFields(Map<String, dynamic> userData) {
    final requiredFields = ['email', 'password', 'phone', ];

    if (isCompanyAccount) {
      requiredFields.addAll(['company_name', 'company_date',]);
    } else {
      requiredFields.addAll(['first_name', 'last_name', 'birth_date','role']);
    }

    for (var field in requiredFields) {
      if (userData[field]?.toString().trim().isEmpty ?? true) {
        return false;
      }
    }

    return true;
  }

  // API calls
  Future<bool> signUpUser(BuildContext context, Map<String, dynamic> userData) async {
    try {
      _setLoading(true);
      print("User Data: $userData");

      final response = await _createUserAccount(userData);

      if (_isSuccessResponse(response)) {
        return true;
      } else {
        _handleSignUpError(context, 'فشل التسجيل: ${response.statusMessage}');
        return false;
      }
    } catch (e) {
      _handleException(context, e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<Response> _createUserAccount(Map<String, dynamic> userData) async {
    if (isCompanyAccount) {
      return await _createBusinessAccount(userData);
    } else {
      return await _createPersonalAccount(userData);
    }
  }

  Future<Response> _createBusinessAccount(Map<String, dynamic> userData) async {
    final owner = User(
      email: userData['email'],
      password: userData['password'],
      phoneNumber: '$_phonePrefix${userData['phone']}',
      firstName: userData['first_name'] ?? '',
      lastName: userData['last_name'] ?? '',
      businessName: userData['company_name'],
      businessLicense: userData['tax_number'],
      birthday: _parseDate(userData['company_date']),
      roles: ['business_owner'],
    );

    print('SIGNING UP BUSINESS: ${owner.toJson()}');
    return await _authRepository.signUp(owner);
  }

  Future<Response> _createPersonalAccount(Map<String, dynamic> userData) async {
    final account = User(
      email: userData['email'],
      password: userData['password'],
      phoneNumber: '$_phonePrefix${userData['phone']}',
      firstName: userData['first_name'],
      lastName: userData['last_name'],
      birthday: _parseDate(userData['birth_date']),
      roles: ['personal_user'],
    );

    print('SIGNING UP PERSONAL: ${account.toJson()}');
    final response = await _authRepository.signUp(account);
    print('STATUS CODE: ${response.statusCode}');
    return response;
  }

  DateTime? _parseDate(String? dateString) {
    if (dateString == null || dateString.trim().isEmpty) return null;

    try {
      return DateFormat(_dateFormat).parse(dateString);
    } catch (e) {
      print('Date parsing error: $e');
      return null;
    }
  }

  bool _isSuccessResponse(Response response) {
    return response.statusCode == 200 || response.statusCode == 201;
  }

  void _setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  // Error handling
  void _handleException(BuildContext context, dynamic error) {
    if (error is DioException) {
      _handleDioException(context, error);
    } else {
      print('ERROR: $error');
      showErrorMessage(context, 'حدث خطأ أثناء التسجيل');
    }
  }

  void _handleDioException(BuildContext context, DioException error) {
    print('SIGN UP ERROR: ${error.message}');
    print('RESPONSE DATA: ${error.response?.data}');
    print('STATUS CODE: ${error.response?.statusCode}');

    final responseData = error.response?.data;

    if (_isValidationError(responseData)) {
      final translatedError = _translateValidationError(responseData['field']);
      showErrorMessage(context, translatedError);
    } else {
      showErrorMessage(context, 'حدث خطأ أثناء التسجيل');
    }
  }

  bool _isValidationError(dynamic responseData) {
    return responseData != null &&
        responseData is Map<String, dynamic> &&
        responseData.containsKey('field') &&
        responseData.containsKey('error');
  }

  String _translateValidationError(String field) {
    switch (field) {
      case 'phoneNumber':
        return 'رقم الهاتف مستخدم بالفعل';
      case 'email':
        return 'البريد الإلكتروني مستخدم بالفعل';
      default:
        return 'خطأ في الحقل: $field';
    }
  }

  void _handleSignUpError(BuildContext context, String message) {
    showErrorMessage(context, message);
  }

  void showErrorMessage(BuildContext context, String message) {
    customShowSnackBar(context, message, errorColor);
  }

  void customShowSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
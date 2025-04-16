import 'package:Levant_Sale/src/modules/auth/repos/auth-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/business-owner-model.dart';
import '../../../models/personal-model.dart';
import '../verify/verify.dart';

class SignUpProvider extends ChangeNotifier {
  bool isLoading = false;
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

  void toggleAgreement(bool? value) {
    if (value != null) {
      _agreeToTerms = value;
      notifyListeners();
    }
  }

  void setSelectedValue(String? value) {
    if (value != null) {
      _selectedValue = value;
      notifyListeners();
    }
  }

  Future<void> signUpUser(
      BuildContext context, Map<String, dynamic> userData) async {
    isLoading = true;
    notifyListeners();
    print("User Data: $userData");
    try {
      Response response;

      if (_selectedValue == 'شركة') {
        final owner = BusinessOwner(
          username: userData['email'],
          email: userData['email'],
          password: userData['password'],
          phoneNumber: userData['phone'],
          firstName: userData['first_name'],
          lastName: userData['last_name'],
          profilePicture: null,
          isVerified: false,
          businessName: userData['company_name'],
          businessLicense: userData['tax_number'],
          birthday: userData['birth_date'] != null
              ? DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(
                  DateFormat('MMMM d, yyyy').parse(userData['birth_date']))
              : '',
          active: true,
          status: 'PENDING',
          roles: ['business_owner'],
        );

        print('SIGNING UP BUSINESS: ${owner.toJson()}');

        response = await _authRepository.signUpBusinessOwner(owner);
      } else if (_selectedValue == 'شخصي') {
        final account = PersonalModel(
          username: userData['email'],
          email: userData['email'],
          password: userData['password'],
          phoneNumber: userData['phone'],
          firstName: userData['first_name'],
          lastName: userData['last_name'],
          profilePicture: null,
          isVerified: false,
          birthday: userData['birth_date'] != null
              ? DateFormat('yyyy-MM-dd').format(
                  DateFormat('MMMM d, yyyy').parse(userData['birth_date']))
              : null,
          active: true,
          status: 'PENDING',
          roles: ['personal_user'],
        );

        print('SIGNING UP PERSONAL: ${account.toJson()}');

        response = await _authRepository.signUpPersonalAccount(account);
        print('STATUS CODE:${response.statusCode}');
      } else {
        customShowSnackBar(context, 'يرجى اختيار نوع الحساب', Colors.redAccent);
        isLoading = false;
        notifyListeners();
        return;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushNamed(context, VerificationScreen.id);
      } else {
        customShowSnackBar(context, 'فشل التسجيل: ${response.statusMessage}',
            Colors.redAccent);
      }
    } catch (e) {
      if (e is DioException) {
        print('SIGN UP ERROR: ${e.message}');
        print('RESPONSE DATA: ${e.response?.data}');
        print('STATUS CODE: ${e.response?.statusCode}');
      } else {
        print('ERROR: $e');
      }

      customShowSnackBar(
        context,
        'حدث خطأ أثناء التسجيل: ${e.toString()}',
        Colors.redAccent,
      );
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

import 'package:Levant_Sale/src/modules/auth/repos/auth-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/business-owner-model.dart';
import '../../../models/personal-model.dart';
import '../verify/verify.dart';

class SignUpProvider extends ChangeNotifier {
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('MMMM dd, yyyy').format(DateTime.now()));
  String? selectedValue;
  bool isLoading = false;
  String? errorMessage;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthDateController = TextEditingController();

  final companyNameController = TextEditingController();
  final companyDateController = TextEditingController();
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

  void toggleAgreement(bool? value) {
    if (value != null) {
      _agreeToTerms = value;
      notifyListeners();
    }
  }

  void setSelectedValue(String? value) {
    if (value != null && _selectedValue != value) {
      _selectedValue = value;
      notifyListeners();
    }
  }

  void signUpUser(BuildContext context, Map<String, dynamic> userData) {
    if (_selectedValue == 'شركة') {
      final owner = BusinessOwner(
        username: userData['email'],
        email: userData['email'],
        password: userData['password'],
        phoneNumber: userData['phone'],
        firstName: userData['first_name'],
        lastName: userData['last_name'],
        profilePicture: '',
        isVerified: false,
        businessName: userData['company_name'],
        businessLicense: userData['tax_number'],
        birthday: userData['birth_date'],
        verificationToken: '',
        active: true,
        oauth2Provider: '',
        status: 'PENDING',
        roles: ['business_owner'],
      );

      _authRepository.signUpBusinessOwner(owner);
    } else if (_selectedValue == 'شخصي') {
      final account = PersonalModel(
        username: userData['email'], // أو اسم مخصص
        email: userData['email'],
        password: userData['password'],
        phoneNumber: userData['phone'],
        firstName: userData['first_name'],
        lastName: userData['last_name'],
        profilePicture: '',
        isVerified: false,
        birthday: userData['birth_date'],
        active: true,
        status: 'PENDING',
        roles: ['personal_user'],
      );

      _authRepository.signUpPersonalAccount(account);
    } else {
      customShowSnackBar(context, 'يرجى اختيار نوع الحساب', Colors.redAccent);
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

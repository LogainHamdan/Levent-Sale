import 'package:Levant_Sale/src/modules/auth/repos/auth-repo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../verify/verify.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('MMMM dd, yyyy').format(DateTime.now()));
  String? selectedValue;

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

  void setDropdownOpened(bool value) {
    _isDropdownOpened = value;
    notifyListeners();
  }

  Future<void> registerUser(
      BuildContext context, Map<String, dynamic> userData) async {
    try {
      final response = await _authRepository.registerUser(userData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSnackBar(context, "تم التسجيل بنجاح");
        Navigator.pushNamed(context, VerificationScreen.id);
      } else {
        _showSnackBar(context, "حدث خطأ غير متوقع. حاول مرة أخرى.");
      }
    } catch (e) {
      _showSnackBar(context, "فشل في التسجيل: ${e.toString()}");
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

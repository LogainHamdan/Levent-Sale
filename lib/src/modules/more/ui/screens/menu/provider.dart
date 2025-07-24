import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../repositories/change-pass-repo.dart';

class MenuProvider with ChangeNotifier {
  bool isLoading = false;

  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController sentCodeController = TextEditingController();
  final TextEditingController newPassAlertController = TextEditingController();
  final TextEditingController confirmNewPassAlertController =
      TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmNewPassController =
      TextEditingController();

  @override
  void dispose() {
    oldPassController.dispose();
    sentCodeController.dispose();
    newPassAlertController.dispose();
    confirmNewPassAlertController.dispose();
    newPassController.dispose();
    confirmNewPassController.dispose();
    super.dispose();
  }

  Future<void> submitChangePassword({
    required BuildContext context,
    required int userId,
    required String token,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final Response response = await ChangePasswordRepository().changePassword(
        userId,
        newPassController.text.trim(),
        oldPassController.text.trim(),
        token: token,
      );
      print(response);
      if (response.statusCode == 200) {
        _showSuccess(context, 'تم تغيير كلمة المرور بنجاح');
      }
    } catch (e) {
      debugPrint('$e');
      _showError(context, 'فشل الاتصال بالخادم');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: kprimaryColor),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../login/provider.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isConfirmField;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hint,
    this.isConfirmField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        bool isVisible = isConfirmField
            ? loginProvider.confirmPasswordVisible
            : loginProvider.passwordVisible;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.h),
          child: TextField(
            controller: controller,
            obscureText: !isVisible,
            cursorColor: Colors.black,
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              fillColor: grey8,
              filled: true,
              hintTextDirection: TextDirection.rtl,
              hintStyle: TextStyle(
                color: grey4,
                fontSize: 14.sp,
              ),
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide.none,
              ),
              prefixIcon: GestureDetector(
                onTap: () => loginProvider.togglePasswordVisibility(
                  isConfirmField: isConfirmField,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0.sp),
                  child: Image.asset(
                    isVisible
                        ? 'assets/imgs_icons/auth/assets/icons/seen.png'
                        : 'assets/imgs_icons/auth/assets/icons/unseen.png',
                    height: 1.h,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

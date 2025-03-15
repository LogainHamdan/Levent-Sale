import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../login/provider.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const CustomPasswordField({
    Key? key,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        return TextField(
          controller: controller,
          obscureText: !loginProvider.passwordVisible,
          textDirection: TextDirection.ltr,
          cursorColor: Colors.black,
          style: TextStyle(fontSize: 14.sp, color: Colors.black),
          decoration: InputDecoration(
            fillColor: grey6,
            filled: true,
            hintTextDirection: TextDirection.rtl,
            hintStyle: TextStyle(
              color: grey4,
              fontSize: 14.sp,
            ),
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            prefixIcon: GestureDetector(
              onTap: loginProvider.togglePasswordVisibility,
              child: Padding(
                padding: EdgeInsets.all(12.0.sp),
                child: Image.asset(
                  loginProvider.passwordVisible
                      ? 'assets/imgs_icons/auth/assets/icons/seen.png'
                      : 'assets/imgs_icons/auth/assets/icons/unseen.png',
                  height: 1.h,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

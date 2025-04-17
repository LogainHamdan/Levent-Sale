import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../../login/provider.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isConfirmField;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hint,
    this.isConfirmField = false,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        bool isVisible = isConfirmField
            ? loginProvider.confirmPasswordVisible
            : loginProvider.passwordVisible;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: grey8,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      loginProvider.togglePasswordVisibility(
                        isConfirmField: isConfirmField,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: !isVisible
                          ? SvgPicture.asset(
                              unseenPath,
                              height: 20.h,
                              width: 20.h,
                            )
                          : Image.asset(
                              seenPath,
                              height: 20.h,
                              width: 20.h,
                            ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      obscureText: !isVisible,
                      cursorColor: Colors.black,
                      onChanged: onChanged,
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.tajawal(
                        textStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 14.h,
                          horizontal: 10.w,
                        ),
                        hintText: hint,
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: grey3,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (errorText != null)
              Padding(
                padding: EdgeInsets.only(top: 4.h, right: 8.w),
                child: Text(
                  errorText!,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

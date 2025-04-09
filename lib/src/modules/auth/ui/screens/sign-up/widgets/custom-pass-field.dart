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

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hint,
    this.isConfirmField = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, loginProvider, child) {
        bool isVisible = isConfirmField
            ? loginProvider.confirmPasswordVisible
            : loginProvider.passwordVisible;

        return SizedBox(
          height: 48.h,
          child: TextField(
            controller: controller,
            obscureText: !isVisible,
            cursorColor: Colors.black,
            onChanged: onChanged,
            style: GoogleFonts.tajawal(
              textStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              fillColor: grey8,
              filled: true,
              hintTextDirection: TextDirection.rtl,
              hintStyle: GoogleFonts.tajawal(
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  color: grey3,
                  fontWeight: FontWeight.normal,
                ),
              ),
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: Color(0xffe5e7eb)),
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
            ),
          ),
        );
      },
    );
  }
}

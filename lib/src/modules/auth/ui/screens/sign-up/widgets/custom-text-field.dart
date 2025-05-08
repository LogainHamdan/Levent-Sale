import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final TextInputType keyboardType;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final TextDirection textDirection;
  final Color bgcolor;
  final bool? paragraph;
  final String? label;
  final Widget? suffix;
  final Widget? prefix;
  final double? paragraphBorderRadius;
  final bool? labelGrey;
  final bool isRequired;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hint = '',
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.onChanged,
    this.textDirection = TextDirection.rtl,
    required this.bgcolor,
    this.paragraph = false,
    this.label = '',
    this.suffix,
    this.paragraphBorderRadius,
    this.prefix,
    this.labelGrey = false,
    this.isRequired = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final bool showError = errorText != null && errorText!.isNotEmpty;
    final provider = Provider.of<SignUpProvider>(context);
    return !paragraph!
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (label!.isNotEmpty)
                Text(
                  textAlign: TextAlign.right,
                  label!,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: labelGrey! ? grey5 : Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              SizedBox(
                height: 4.h,
              ),
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                obscureText: isPassword,
                textDirection: textDirection,
                cursorColor: Colors.black,
                style: GoogleFonts.tajawal(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                decoration: InputDecoration(
                  prefix: prefix,
                  suffixIcon: suffix,
                  hintText: hint ?? '',
                  fillColor: bgcolor,
                  filled: true,
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: GoogleFonts.tajawal(
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      color: grey3,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide:
                        // showError
                        //     ? const BorderSide(color: Color(0xffF75555), width: 2.0)
                        //     :
                        //
                        BorderSide.none,
                  ),
                  // enabledBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10.r),
                  //   borderSide: showError
                  //       ? const BorderSide(color: Color(0xffF75555), width: 2.0)
                  //       : BorderSide.none,
                  // ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10.r),
                  //   borderSide: showError
                  //       ? const BorderSide(color: Color(0xffF75555), width: 2.0)
                  //       : BorderSide.none,
                  // ),
                  errorText: null,
                ),
                onChanged: onChanged,
              ),
              if (showError)
                Padding(
                  padding: EdgeInsets.only(top: 4.h, right: 8.w),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      errorText!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xffF75555),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (label!.isNotEmpty)
                Text(
                  textAlign: TextAlign.right,
                  label!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: labelGrey! ? grey5 : Colors.black,
                  ),
                ),
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                obscureText: isPassword,
                textDirection: textDirection,
                cursorColor: Colors.black,
                maxLines: 5,
                decoration: InputDecoration(
                  fillColor: bgcolor,
                  filled: true,
                  hintText: hint!,
                  hintStyle: TextStyle(color: grey3, fontSize: 16.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: showError
                        ? const BorderSide(color: Color(0xffF75555), width: 2.0)
                        : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(paragraphBorderRadius!.r),
                    borderSide: showError
                        ? const BorderSide(color: Color(0xffF75555), width: 2.0)
                        : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(paragraphBorderRadius!.r),
                    borderSide: showError
                        ? const BorderSide(color: Color(0xffF75555), width: 2.0)
                        : BorderSide.none,
                  ),
                  errorText: errorText,
                ),
                style: TextStyle(
                  fontSize: 16.0.sp,
                  color: Colors.black,
                ),
                onChanged: onChanged,
              ),
              if (showError)
                Padding(
                  padding: EdgeInsets.only(top: 4.h, right: 8.w),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      errorText!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xffF75555),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
            ],
          );
  }
}

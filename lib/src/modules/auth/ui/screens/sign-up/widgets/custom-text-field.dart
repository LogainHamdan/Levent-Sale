import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
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
  final bool? isRequired;
  final String? errorText;
  final bool numbersOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hint = '',
    this.isPassword = false,
    this.onChanged,
    this.textDirection = TextDirection.rtl,
    required this.bgcolor,
    this.paragraph = false,
    this.label = '',
    this.suffix,
    this.paragraphBorderRadius = 10,
    this.prefix,
    this.labelGrey = false,
    this.isRequired = false,
    this.errorText,
    this.numbersOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool showError = errorText != null &&
        errorText!.isNotEmpty &&
        (controller.text.isEmpty || controller.text.trim().isEmpty);

    return paragraph == false
        ? _buildSingleLineField(showError)
        : _buildMultiLineField(showError);
  }

  Widget _buildSingleLineField(bool showError) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (label!=null) ...[
          Text(
            label ?? '',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14.sp,
              color: labelGrey ?? false ? grey5 : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),

        ],
        TextField(
          controller: controller,
          obscureText: isPassword,
          textDirection: textDirection,
          cursorColor: Colors.black,
          keyboardType: numbersOnly ? TextInputType.number : TextInputType.text,
          inputFormatters: numbersOnly
              ? [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ]
              : null,
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
              borderSide: BorderSide.none,
            ),
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
                errorText ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: errorColor,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMultiLineField(bool showError) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (label != null && label!.isNotEmpty) ...[
          Text(
            label ?? '',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14.sp,
              color: labelGrey ?? false ? grey5 : Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
        ],
        TextField(
          controller: controller,
          obscureText: isPassword,
          textDirection: textDirection,
          cursorColor: Colors.black,
          maxLines: 5,
          keyboardType: numbersOnly ? TextInputType.number : TextInputType.multiline,
          inputFormatters: numbersOnly
              ? [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ]
              : null,
          style: GoogleFonts.tajawal(
            textStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
          decoration: InputDecoration(
            fillColor: bgcolor,
            filled: true,
            hintText: hint ?? '',
            hintTextDirection: TextDirection.rtl,
            hintStyle: GoogleFonts.tajawal(
              textStyle: TextStyle(
                color: grey3,
                fontSize: 16.sp,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(paragraphBorderRadius ?? 10.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(paragraphBorderRadius ?? 10.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(paragraphBorderRadius ?? 10.r),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: onChanged,
        ),
        if (showError)
          Padding(
            padding: EdgeInsets.only(top: 4.h, right: 8.w),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                errorText ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: errorColor,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
      ],
    );
  }
}
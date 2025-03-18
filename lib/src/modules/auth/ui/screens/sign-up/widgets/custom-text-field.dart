import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final TextDirection textDirection;
  final Color bgcolor;
  final bool? paragraph;
  final String? label;
  final Widget? suffix;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.onChanged,
    this.textDirection = TextDirection.rtl,
    required this.bgcolor,
    this.paragraph = false,
    this.label = '',
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return !paragraph!
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    label!,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  obscureText: isPassword,
                  textDirection: textDirection,
                  cursorColor: Colors.black,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: suffix,
                    hintText: hint,
                    fillColor: bgcolor,
                    filled: true,
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: TextStyle(color: grey4, fontSize: 14.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: onChanged,
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  textAlign: TextAlign.right,
                  label!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
                Container(
                  child: TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    obscureText: isPassword,
                    textDirection: textDirection,
                    cursorColor: Colors.black,
                    maxLines: 5,
                    decoration: InputDecoration(
                      fillColor: bgcolor,
                      filled: true,
                      hintText: hint,
                      hintStyle: TextStyle(color: grey4, fontSize: 16.sp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      color: Colors.black,
                    ),
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          );
  }
}

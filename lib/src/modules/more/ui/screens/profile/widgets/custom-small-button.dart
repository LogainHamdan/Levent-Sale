import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSmallButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String text;
  final bool isOutlined;
  final Color? textColor;
  final Color? buttonColor;

  const CustomSmallButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.isOutlined,
    this.textColor = Colors.white,
    this.buttonColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      child: isOutlined
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(color: textColor ?? Colors.white),
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text,
                      style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                              fontSize: 16.sp,
                              color: textColor,
                              fontWeight: FontWeight.w500))),
                  SizedBox(width: 10.w),
                  icon,
                ],
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text,
                      style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                              fontSize: 16.sp,
                              color: textColor,
                              fontWeight: FontWeight.w500))),
                  SizedBox(width: 10.w),
                  icon,
                ],
              ),
            ),
    );
  }
}

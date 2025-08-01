import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool? date;
  final Widget? icon;
  final double? fontSize;
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.date = false,
    this.icon,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: GoogleFonts.tajawal(
                  fontSize: fontSize!.sp, fontWeight: FontWeight.w500),
              backgroundColor: backgroundColor,
              minimumSize:
                  date! ? Size(140.w, 45.h) : Size(double.infinity, 45.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              maxLines: 1,
              text,
              style: TextStyle(color: textColor),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              textStyle: GoogleFonts.tajawal(
                  fontSize: fontSize!.sp, fontWeight: FontWeight.w500),
              backgroundColor: backgroundColor,
              minimumSize:
                  date! ? Size(140.w, 50.h) : Size(double.infinity, 50.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
                SizedBox(
                  width: 14.w,
                ),
                icon!
              ],
            ),
          );
  }
}

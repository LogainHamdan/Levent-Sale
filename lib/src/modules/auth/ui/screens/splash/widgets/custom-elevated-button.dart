import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool date;
  final bool notText;
  const CustomElevatedButton({
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    required this.date,
    required this.notText,
  });

  @override
  Widget build(BuildContext context) {
    return !notText
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              textStyle: GoogleFonts.tajawal(
                  fontSize: 20.sp, fontWeight: FontWeight.w500),
              backgroundColor: backgroundColor,
              minimumSize:
                  date ? Size(140.w, 50.h) : Size(double.infinity, 50.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r), // Less border radius
              ),
            ),
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              textStyle: GoogleFonts.tajawal(
                  fontSize: 20.sp, fontWeight: FontWeight.w500),
              backgroundColor: backgroundColor,
              minimumSize:
                  date ? Size(140.w, 50.h) : Size(double.infinity, 50.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r), // Less border radius
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
                Image.asset(
                  'assets/imgs_icons/home/assets/icons/chat-white.png',
                  height: 20.h,
                  width: 20.w,
                )
              ],
            ),
          );
  }
}

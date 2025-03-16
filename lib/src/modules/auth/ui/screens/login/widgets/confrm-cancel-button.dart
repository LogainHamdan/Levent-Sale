import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmCancelButton extends StatelessWidget {
  final Function() onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  const ConfirmCancelButton(
      {super.key,
      required this.onPressed,
      required this.backgroundColor,
      required this.textColor,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: Text(
            'الغاء',
            style: GoogleFonts.tajawal(
                color: Colors.orange,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            textStyle: GoogleFonts.tajawal(
                fontSize: 20.sp, fontWeight: FontWeight.w500),
            backgroundColor: backgroundColor,
            minimumSize: Size(150.w, 50.h),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }
}

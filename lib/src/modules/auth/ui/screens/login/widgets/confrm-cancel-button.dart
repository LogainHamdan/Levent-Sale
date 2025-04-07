import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';

class ConfirmCancelButton extends StatelessWidget {
  final Function() onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final bool? date;
  const ConfirmCancelButton(
      {super.key,
      required this.onPressed,
      required this.backgroundColor,
      required this.textColor,
      required this.text,
      this.date = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: Text(
            'الغاء',
            style: GoogleFonts.tajawal(
                color: cancelColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(
          width: 40.w,
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            textStyle: GoogleFonts.tajawal(
                fontSize: 20.sp, fontWeight: FontWeight.w500),
            backgroundColor: backgroundColor,
            minimumSize: date! ? Size(130.w, 48.h) : Size(194.w, 48.h),
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

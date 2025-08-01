import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';
import '../../ads/ads.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const CustomHeader({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: onPressed,
            child: Text('مشاهدة المزيد',
                textDirection: TextDirection.rtl,
                style: GoogleFonts.tajawal(
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: kprimaryColor,
                  ),
                ))),
        Text(
          title,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

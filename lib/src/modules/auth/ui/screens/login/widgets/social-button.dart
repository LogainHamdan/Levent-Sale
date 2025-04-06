import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final String image;
  final Color color;
  final bool facebook;

  const SocialButton(
      {required this.text,
      required this.image,
      this.color = Colors.grey,
      required this.facebook});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      width: 327.w,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          textStyle:
              GoogleFonts.tajawal(fontSize: 14.sp, fontWeight: FontWeight.w500),
          side: BorderSide(color: grey6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            facebook
                ? Text(
                    text,
                    style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    textDirection: TextDirection.rtl,
                  )
                : Text(
                    text,
                    style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    textDirection: TextDirection.rtl,
                  ),
            SizedBox(
              width: 10.w,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: SvgPicture.asset(
                  image,
                  width: 24.w,
                  height: 24.h,
                )),
          ],
        ),
      ),
    );
  }
}

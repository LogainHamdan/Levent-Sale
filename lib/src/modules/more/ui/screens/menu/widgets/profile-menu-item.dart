import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';

class MenuItem extends StatelessWidget {
  final Color color;
  final String title;
  final Widget icon;

  const MenuItem(this.title, this.icon, {super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        color: grey8,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ListTile(
        trailing: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: icon,
        ),
        title: Text(
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          title,
          style: GoogleFonts.tajawal(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        leading:
            Icon(Icons.arrow_back_ios_new, size: 18.sp, color: Colors.black45),
      ),
    );
  }
}

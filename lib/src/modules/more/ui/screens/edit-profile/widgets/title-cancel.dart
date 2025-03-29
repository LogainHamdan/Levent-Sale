import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';

class CustomTitleCancel extends StatelessWidget {
  final String title;
  const CustomTitleCancel({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: GoogleFonts.tajawal(
              textStyle:
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            cancelPath,
            height: 15.h,
          ),
        )
      ],
    );
  }
}

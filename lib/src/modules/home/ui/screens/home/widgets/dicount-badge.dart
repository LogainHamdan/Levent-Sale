import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.r), bottomLeft: Radius.circular(17.r)),
      child: Container(
        height: 16.h,
        width: 36.w,
        padding: EdgeInsets.symmetric(vertical: 1.h),
        color: kprimaryColor,
        child: Center(
          child: Text(
            '-25%',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }
}

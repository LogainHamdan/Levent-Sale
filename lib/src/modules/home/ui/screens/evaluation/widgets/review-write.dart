import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class ReviewWrite extends StatelessWidget {
  const ReviewWrite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          textAlign: TextAlign.center, // Center the hint text
          decoration: InputDecoration(
            hintText: 'اكتب تقييمك',
            fillColor: grey8,
            filled: true,
            hintTextDirection: TextDirection.rtl,
            hintStyle: TextStyle(color: Colors.black, fontSize: 18.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          ),
        ),
        Positioned(
          right: 80.w,
          top: 0,
          bottom: 2,
          child: GestureDetector(
            onTap: () {},
            child: Image.asset(
              'lib/src/modules/home/ui/assets/icons/edit.png',
              height: 25.h,
              width: 25.w,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class PhoneSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: grey7,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '598 789 458',
                  hintStyle: TextStyle(
                    color: grey4,
                    fontSize: 18,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              )),
        ),
        SizedBox(width: 10.w),
        Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: grey7,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/arrow-down.png',
                height: 15.h,
              ),
              SizedBox(width: 16.w),
              Text(
                '+963',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../../config/constants.dart';

class PhoneSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Ensure width is constrained
      width: double.infinity,
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Ensures proper spacing
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
                    fontSize: 18.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            width: 100.w, // Defined width for consistency
            height: 50.h,
            decoration: BoxDecoration(
              color: grey7,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10.0.h),
              child: IntlPhoneField(
                decoration: InputDecoration(
                    labelText: 'Phone',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 12.sp),
                    border: InputBorder.none,
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.bold, color: grey4)),
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
                cursorColor: Colors.black,
                initialCountryCode: 'SY',
                dropdownIcon: Icon(Icons.arrow_drop_down, color: Colors.black),
                onChanged: (phone) {},
                disableLengthCheck: true, // Removes the 1/10, 2/10, etc.
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../../config/constants.dart';

class PhoneSection extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  const PhoneSection({
    super.key,
    this.hint = '598 789 458',
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: grey7,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: GoogleFonts.tajawal(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: grey4,
                      fontSize: 16.sp,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
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
            width: 100.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: grey7,
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: IntlPhoneField(
                initialCountryCode: 'SY',
                enabled: false,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

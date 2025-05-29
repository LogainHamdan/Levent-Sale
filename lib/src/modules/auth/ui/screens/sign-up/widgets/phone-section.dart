import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../provider.dart';

class PhoneSection extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final String? errorText;

  const PhoneSection({
    super.key,
    this.hint = '598 789 458',
    required this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: grey7,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: TextField(
                    controller: controller,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(9),
                      FilteringTextInputFormatter.digitsOnly, // ✅ Digits only
                    ],
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
              // Country code (disabled)
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
        ),
        if ((signUpProvider.hasTriedSubmit) &&
            errorText != null &&
            errorText!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 4.h, right: 8.w),
            child: Text(
              errorText!,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Color(0xffF75555),
                fontSize: 12.sp,
              ),
            ),
          ),
      ],
    );
  }
}

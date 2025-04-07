import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants.dart';

class EmptyTextField extends StatelessWidget {
  final TextEditingController controller;
  const EmptyTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Center(
        child: TextField(
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            fillColor: greySplash,
            filled: true,
            hintTextDirection: TextDirection.rtl,
            hintStyle: TextStyle(color: grey4, fontSize: 14.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
          ),
          controller: controller,
        ),
      ),
    );
  }
}

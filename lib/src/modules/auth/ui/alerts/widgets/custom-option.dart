import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOption extends StatelessWidget {
  final String text;
  const CustomOption({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
      ),
    );
  }
}

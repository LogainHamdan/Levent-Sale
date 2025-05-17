import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
    );
  }
}

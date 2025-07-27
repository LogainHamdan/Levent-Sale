import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class CustomLabel extends StatelessWidget {
  final bool? grey;
  const CustomLabel({
    super.key,
    required this.text,
    this.grey = false,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: grey! ? grey5 : Colors.black),
    );
  }
}

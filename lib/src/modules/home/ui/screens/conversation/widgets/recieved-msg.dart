import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class SentMsg extends StatelessWidget {
  final String text;
  final DateTime time;
  const SentMsg({super.key, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: kprimaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.r),
            topLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            SizedBox(height: 5.h),
            Text(
              "${time.hour > 12 ? time.hour - 12 : time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'م' : 'ص'}",
              textDirection: TextDirection.rtl,
              style: TextStyle(color: grey7, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}

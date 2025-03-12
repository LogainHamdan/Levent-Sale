import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class CustomRating extends StatelessWidget {
  final bool rateNum;
  const CustomRating({
    super.key,
    required this.rateNum,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: StarRating(
            rating: 4.4,
            size: 25.sp,
            color: amberColor,
          ),
        ),
        SizedBox(width: 5.w),
        rateNum
            ? Text(
                '4.4',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              )
            : SizedBox()
      ],
    );
  }
}

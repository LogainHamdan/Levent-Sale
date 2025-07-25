import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/alerts/alert.dart';

class ReviewWrite extends StatelessWidget {
  final int adId;
  const ReviewWrite({
    super.key,
    required this.adId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showRatingDialog(context, adId),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: grey8,
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(
              'اكتب تقييمك',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
            ),
          ),
          Positioned(
            right: 80.w,
            top: 0,
            bottom: 2,
            child: SvgPicture.asset(
              editBlackIcon,
              height: 25.h,
              width: 25.w,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';
import '../../../../../sections/models/ad.dart';

class ChatAdContainer extends StatelessWidget {
  const ChatAdContainer({
    super.key,
    required this.ad,
  });

  final AdModel? ad;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
          color: grey7, borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              ad?.imageUrls?.first ?? '',
              width: 80.w,
              height: 50.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            ad?.title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            '${ad?.currency ?? ''} ${ad?.price ?? ''}',
            style: TextStyle(
              fontSize: 10.sp,
              color: grey3,
            ),
          ),
        ],
      ),
    );
  }
}

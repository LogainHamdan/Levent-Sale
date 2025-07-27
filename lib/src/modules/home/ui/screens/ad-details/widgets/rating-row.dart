import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class RatingRow extends StatelessWidget {
  final int stars;
  final int count;
  final double value;

  const RatingRow({
    super.key,
    required this.stars,
    required this.count,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // اتجاه النص من اليمين لليسار
      child: SizedBox(
        width: 191.w,
        child: Row(
          children: [
            // هذا النص سيبقى ثابتًا على اليسار
            Text(
              '$stars',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.star, color: Colors.amber, size: 16.sp),
            SizedBox(width: 4.w),

            // المسافة بين النص والمربع
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: Color(0xFFE6F1D2),
                  valueColor: AlwaysStoppedAnimation<Color>(kprimaryColor),
                  minHeight: 5,
                ),
              ),
            ),

            // المحاذاة للـ count بحيث يبدأ من نفس نقطة البداية
            SizedBox(width: 8.w),
            Text(
              '$count',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

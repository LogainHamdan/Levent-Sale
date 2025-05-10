import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCoverColumn extends StatelessWidget {
  const AddCoverColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 4.h,
        ),
        Icon(
          Icons.arrow_downward_rounded,
          color: Colors.white,
          size: 30.sp,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          'أضف صورة بانر\nالأبعاد المثالية 3200 * 410 بكسل',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

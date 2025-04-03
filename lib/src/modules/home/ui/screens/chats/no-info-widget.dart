import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NoInfoWidget extends StatelessWidget {
  final String img;
  final String msg;

  const NoInfoWidget({
    super.key,
    required this.img,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            img,
            height: 180.h,
            width: 180.w,
          ),
          SizedBox(height: 16.h),
          Text(
            msg,
            style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

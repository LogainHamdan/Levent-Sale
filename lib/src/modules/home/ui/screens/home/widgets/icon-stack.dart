import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class IconStack extends StatelessWidget {
  const IconStack({
    super.key,
    required this.img,
    required this.count,
  });

  final String img;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: 35.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: grey7,
      ),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              img,
              height: 15.h,
              width: 15.h,
              fit: BoxFit.contain,
            ),
            Positioned(
              top: -6.r,
              right: -4.r,
              child: CircleAvatar(
                radius: 7.r,
                backgroundColor: kprimaryColor,
                child: Text(
                  count,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

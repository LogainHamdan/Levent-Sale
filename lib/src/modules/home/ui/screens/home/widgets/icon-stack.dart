import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../config/constants.dart';

class IconStack extends StatelessWidget {
  const IconStack({
    super.key,
    required this.img,
    required this.count,
    required this.onTap,
  });

  final String img;
  final String count;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 40.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: grey7,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(
                img,
                height: 24.h,
                width: 24.h,
                fit: BoxFit.contain,
              ),
              Positioned(
                top: -6.r,
                right: -4.r,
                child: CircleAvatar(
                  radius: 8.r,
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
      ),
    );
  }
}

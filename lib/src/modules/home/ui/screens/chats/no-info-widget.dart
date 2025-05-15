import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../conversation/widgets/MsgInput.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../conversation/widgets/MsgInput.dart';

class NoInfoWidget extends StatelessWidget {
  final String img;
  final String msg;
  final Widget? lowerWidget;
  final bool? bottomWidget;

  const NoInfoWidget({
    super.key,
    required this.img,
    required this.msg,
    this.lowerWidget,
    this.bottomWidget = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          !bottomWidget!
              ? SizedBox(
                  height: 250.h,
                  child: Center(
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
                          style: TextStyle(
                              fontSize: 18.sp, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: Center(
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
                          style: TextStyle(
                              fontSize: 18.sp, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ),
          if (lowerWidget != null)
            bottomWidget!
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: lowerWidget,
                  )
                : lowerWidget ?? SizedBox()
        ],
      ),
    );
  }
}

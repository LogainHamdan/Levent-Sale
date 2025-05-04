import 'package:Levant_Sale/src/modules/more/ui/screens/follow/followers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';
import '../../follow/join-follow.dart';

class FollowContainer extends StatelessWidget {
  final int userId;
  final Widget leftChild;
  final Widget rightChild;

  const FollowContainer({
    super.key,
    required this.leftChild,
    required this.rightChild,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => JoinFollow(userId: userId))),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: grey7,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: leftChild,
                ),
              ),
            ),
            VerticalDivider(
              endIndent: 10.h,
              indent: 10.h,
              color: grey5,
              thickness: 1,
              width: 20.w,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0.h),
                  child: rightChild,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

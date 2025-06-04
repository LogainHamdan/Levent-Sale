import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../../../config/constants.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: kprimary2Color,
      direction: ShimmerDirection.fromRightToLeft(),
      enabled: true,
      child: Column(
        children: List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
    // return Center(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       SizedBox(
    //         width: 30.0.w,
    //         height: 30.w,
    //         child: CircularProgressIndicator(
    //           strokeWidth: 3.w,
    //           color: kprimaryColor,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

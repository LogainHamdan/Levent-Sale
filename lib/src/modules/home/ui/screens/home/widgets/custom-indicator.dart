import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 50.0.w,
            height: 50.w,
            child: CircularProgressIndicator(
              strokeWidth: 4.w,
              color: kprimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

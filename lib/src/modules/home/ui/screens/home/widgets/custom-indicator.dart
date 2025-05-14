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
            width: 30.0.w,
            height: 30.w,
            child: CircularProgressIndicator(
              strokeWidth: 3.w,
              color: kprimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

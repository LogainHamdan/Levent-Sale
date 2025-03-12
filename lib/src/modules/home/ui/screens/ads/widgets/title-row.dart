import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/home.dart';

class TitleRow extends StatelessWidget {
  final String title;
  const TitleRow({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 35.w,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_outlined,
            size: 25.sp,
            color: Colors.black,
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, HomeScreen.id),
        )
      ],
    );
  }
}

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class TabButton extends StatelessWidget {
  final String text;
  final int index;

  const TabButton({super.key, required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TabProvider>(context);
    return GestureDetector(
      onTap: () => provider.changeTab(index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color:
                  provider.currentIndex == index ? kprimaryColor : Colors.black,
            ),
          ),
          if (provider.currentIndex == index)
            Container(
              height: 3.h,
              width: 60.w,
              color: kprimaryColor,
            ),
        ],
      ),
    );
  }
}

import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/search-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'icon-stack.dart';

class TopSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          SizedBox(width: 10.w),
          IconStack(
              img: 'assets/imgs_icons/home/assets/icons/notification-black.png',
              count: '3'),
          SizedBox(width: 10.w),
          IconStack(
              img: 'assets/imgs_icons/home/assets/icons/chat-black.png',
              count: '3'),
          SizedBox(width: 10.w),
          SearchField(),
        ],
      ),
    );
  }
}

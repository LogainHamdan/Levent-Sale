import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import 'attach-section.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: grey7,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: TextField(
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: 'اكتب رسالة',
            hintTextDirection: TextDirection.rtl,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            border: InputBorder.none,
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AttachSection(
                  oneOrTwo: 1,
                  icon: Image.asset(
                    'assets/imgs_icons/home/assets/icons/photo-attach.png',
                    height: 20.w,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                AttachSection(
                  oneOrTwo: 2,
                  icon: Image.asset(
                    'assets/imgs_icons/home/assets/icons/link.png',
                    height: 20.w,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants.dart';

class NoChatsScreen extends StatelessWidget {
  static const id = '/conv';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey9,
        elevation: 4.0,
        shadowColor: Colors.grey.withOpacity(0.5),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
          child: IconButton(
            icon: Image.asset(
              'assets/imgs_icons/home/assets/icons/more.png',
              height: 22.h,
            ),
            onPressed: () {},
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
            child: Row(
              children: [
                Text(
                  'محمد',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(width: 10.w),
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/imgs_icons/home/assets/imgs/محمد.png',
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                        height: 30.h,
                        width: 30.w,
                        'assets/imgs_icons/general/page-arrow-back.png'))
              ],
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Column(
              children: [
                Image.asset('assets/imgs_icons/home/assets/icons/no-chat.png',
                    width: 200.w, height: 250.h),
                Text(
                  textDirection: TextDirection.rtl,
                  'لا يوجد محادثة !',
                  style: TextStyle(fontSize: 25.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'اكتب رسالة',
            hintTextDirection: TextDirection.rtl,
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            prefixIcon: Row(
              mainAxisSize:
                  MainAxisSize.min, // Ensures the Row doesn't take full width
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/imgs_icons/home/assets/icons/photo-attach.png',
                    height: 20.w,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/imgs_icons/home/assets/icons/link.png',
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          enabled: false,
        ),
      ),
    );
  }
}

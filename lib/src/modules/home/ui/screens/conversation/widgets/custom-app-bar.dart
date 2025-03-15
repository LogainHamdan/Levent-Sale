import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String iconAsset;
  final String name;
  final String profileImageAsset;

  const CustomAppBar({
    required this.iconAsset,
    required this.name,
    required this.profileImageAsset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: grey9,
      elevation: 4.0,
      shadowColor: Colors.grey.withOpacity(0.5),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
        child: IconButton(
          icon: Image.asset(
            iconAsset,
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
                name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(width: 10.w),
              CircleAvatar(
                backgroundImage: AssetImage(profileImageAsset),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                height: 80.h,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/imgs_icons/general/page-arrow-back.png',
                    height: 80.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

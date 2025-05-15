import 'package:Levant_Sale/src/modules/home/ui/screens/chats/chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../config/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leadingIcon;
  final String name;
  final String profileImageAsset;
  final Function()? additionalBackFunction;

  const CustomAppBar({
    required this.leadingIcon,
    required this.name,
    required this.profileImageAsset,
    super.key,
    this.additionalBackFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: leadingIcon,
        onPressed: () {},
      ),
      backgroundColor: grey9,
      elevation: 0.5,
      shadowColor: Colors.grey.withOpacity(0.5),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
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
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(profileImageAsset),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                  height: 80.h,
                  child: InkWell(
                      child: Icon(
                        Icons.arrow_forward_outlined,
                        size: 24.sp,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        additionalBackFunction;
                      })),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

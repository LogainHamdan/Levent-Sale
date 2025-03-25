import 'package:Levant_Sale/src/modules/more/ui/screens/change-password/change-pass-column.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/favorite.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/widgets/profile-menu-item.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/technical-support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';
import 'info-row.dart';
import 'logout-item.dart';

class LoggedInColumn extends StatelessWidget {
  const LoggedInColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: grey8,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: InfoRow(),
        ),
        SizedBox(height: 20.h),
        MenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, FavoriteScreen.id),
            color: kprimary4Color,
            "المفضلة",
            Image.asset(
              'assets/imgs_icons/more/assets/icons/المفضلة.png',
              height: 15.h,
            )),
        SizedBox(height: 15.h),
        MenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, ChangePassColumn.id),
            color: kprimary4Color,
            "كلمة المرور",
            Image.asset(
              'assets/imgs_icons/more/assets/icons/كلمة المرور.png',
              height: 15.h,
            )),
        SizedBox(height: 15.h),
        MenuItem(
            onTap: () => Navigator.pushReplacementNamed(
                context, TechnicalSupportScreen.id),
            color: kprimary4Color,
            "الدعم الفني",
            Image.asset(
              'assets/imgs_icons/more/assets/icons/الدعم الفني.png',
              height: 15.h,
            )),
        SizedBox(height: 15.h),
        MenuItem(
            onTap: () {},
            color: kprimary4Color,
            "من نحن",
            Image.asset(
              'assets/imgs_icons/more/assets/icons/من نحن.png',
              height: 15.h,
            )),
        SizedBox(height: 15.h),
        MenuItem(
            onTap: () {},
            color: kprimary4Color,
            "سياسة الخصوصية",
            Image.asset(
              'assets/imgs_icons/more/assets/icons/سياسة الخصوصية.png',
              height: 15.h,
            )),
        SizedBox(height: 15.h),
        CustomLogoutItem(),
      ],
    );
  }
}

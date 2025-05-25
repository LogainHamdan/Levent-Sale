import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/evaluations.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/widgets/change-pass-column.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/favorite.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/widgets/profile-menu-item.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/technical-support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../config/constants.dart';
import '../../../../../home/ui/screens/evaluation/my-reviews.dart';
import 'info-row.dart';
import 'logout-item.dart';

class LoggedInColumn extends StatelessWidget {
  const LoggedInColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
        ),
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
            onTap: () => Navigator.pushNamed(context, FavoriteScreen.id),
            color: kprimary4Color,
            "المفضلة",
            SvgPicture.asset(
              myFavIcon,
              height: 16.h,
            )),
        SizedBox(height: 8.h),
        MenuItem(
            onTap: () => Navigator.pushNamed(context, MyReviewsScreen.id),
            color: kprimary4Color,
            "تقييماتي",
            SvgPicture.asset(
              myFavIcon,
              height: 16.h,
            )),
        SizedBox(height: 8.h),
        MenuItem(
            onTap: () => Navigator.pushNamed(context, ChangePassColumn.id),
            color: kprimary4Color,
            "كلمة المرور",
            SvgPicture.asset(
              changePassIcon,
              height: 16.h,
              width: 16.w,
            )),
        SizedBox(height: 8.h),
        MenuItem(
            onTap: () =>
                Navigator.pushNamed(context, TechnicalSupportScreen.id),
            color: kprimary4Color,
            "الدعم الفني",
            SvgPicture.asset(
              techSupportIcon,
              height: 16.h,
              width: 16.w,
            )),
        SizedBox(height: 8.h),
        MenuItem(
            onTap: () {},
            color: kprimary4Color,
            "من نحن",
            SvgPicture.asset(
              whoAreWeIcon,
              height: 16.h,
              width: 16.w,
            )),
        SizedBox(height: 8.h),
        MenuItem(
            onTap: () {},
            color: kprimary4Color,
            "سياسة الخصوصية",
            SvgPicture.asset(
              privacyIcon,
              height: 16.h,
              width: 16.w,
            )),
        SizedBox(height: 8.h),
        CustomLogoutItem(),
      ],
    );
  }
}

import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/favorite.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/widgets/profile-menu-item.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/friend-profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/technical-support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../config/constants.dart';
import 'info-row.dart';
import 'logout-item.dart';

class GuestColumn extends StatelessWidget {
  const GuestColumn({super.key});

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
            onTap: () => Navigator.pushNamed(context, FavoriteScreen.id),
            color: kprimary4Color,
            "المفضلة",
            SvgPicture.asset(
              myFavIcon,
              height: 16.h,
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
            )),
        SizedBox(height: 8.h),
        MenuItem(
            onTap: () {},
            color: kprimary4Color,
            "من نحن",
            SvgPicture.asset(
              whoAreWeIcon,
              height: 16.h,
            )),
        SizedBox(height: 8.h),
        MenuItem(
            onTap: () {},
            color: kprimary4Color,
            "سياسة الخصوصية",
            SvgPicture.asset(
              privacyIcon,
              height: 16.h,
            )),
      ],
    );
  }
}

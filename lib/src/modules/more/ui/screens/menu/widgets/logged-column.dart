import 'package:Levant_Sale/src/modules/more/ui/screens/change-password/change-pass-column.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/favorite.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/widgets/profile-menu-item.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/technical-support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            onTap: () => Navigator.pushNamed(context, FavoriteScreen.id),
            color: kprimary4Color,
            "المفضلة",
            SvgPicture.asset(
              myFavIcon,
              height: 15.h,
            )),
        SizedBox(height: 15.h),
        MenuItem(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MaterialApp(
                          home: Scaffold(
                            backgroundColor: Colors.white,
                            appBar: AppBar(
                              toolbarHeight: 0,
                            ),
                            body: SafeArea(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                              child: ChangePassColumn(alert: false),
                            )),
                          ),
                        ))),
            color: kprimary4Color,
            "كلمة المرور",
            SvgPicture.asset(
              changePassIcon,
              height: 15.h,
            )),
        SizedBox(height: 15.h),
        MenuItem(
            onTap: () =>
                Navigator.pushNamed(context, TechnicalSupportScreen.id),
            color: kprimary4Color,
            "الدعم الفني",
            SvgPicture.asset(
              techSupportIcon,
              height: 15.h,
            )),
        SizedBox(height: 15.h),
        MenuItem(
            onTap: () {},
            color: kprimary4Color,
            "من نحن",
            SvgPicture.asset(
              whoAreWeIcon,
              height: 15.h,
            )),
        SizedBox(height: 15.h),
        MenuItem(
            onTap: () {},
            color: kprimary4Color,
            "سياسة الخصوصية",
            SvgPicture.asset(
              privacyIcon,
              height: 15.h,
            )),
        SizedBox(height: 15.h),
        CustomLogoutItem(),
      ],
    );
  }
}

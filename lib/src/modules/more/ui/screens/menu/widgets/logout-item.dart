import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/screens/login/provider.dart';

class CustomLogoutItem extends StatelessWidget {
  const CustomLogoutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print('button clicked');
        logoutAlert(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          color: grey8,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ListTile(
          trailing: SvgPicture.asset(
            logoutIcon,
            height: 22.h,
          ),
          title: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Text(
              'تسجيل الخروج',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ),
          leading: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: grey3),
        ),
      ),
    );
  }
}

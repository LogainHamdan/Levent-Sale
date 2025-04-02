import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/alerts/alert.dart';

class CustomLogoutItem extends StatelessWidget {
  const CustomLogoutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => logoutAlert(context),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          color: grey8,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ListTile(
          trailing: SvgPicture.asset(
            height: 22.h,
            logoutIcon,
          ),
          title: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              'تسجيل الخروج',
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ),
          leading: Icon(Icons.arrow_back_ios_new,
              size: 18.sp, color: Colors.black45),
        ),
      ),
    );
  }
}

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/edit-profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = Provider.of<MenuProvider>(context).isLoggedIn;

    return isLoggedIn
        ? Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: InkWell(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, EditProfileScreen.id),
                  child: Image.asset(
                    editProfileIcon,
                    height: 30.h,
                  ),
                ),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "منة الله",
                    style: GoogleFonts.tajawal(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "minnabasim12@gmail.com",
                    style: GoogleFonts.tajawal(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                      "assets/imgs_icons/home/assets/imgs/منال.png")),
            ],
          )
        : Row(
            children: [
              Spacer(),
              Text(
                "تسجيل/دخول",
                style: GoogleFonts.tajawal(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 12.w),
              ClipOval(
                child: SvgPicture.asset(
                  personIcon,
                  width: 60.r, // Adjust according to your needs
                  height: 60.r,
                  fit: BoxFit.cover,
                ),
              )
            ],
          );
  }
}

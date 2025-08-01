import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/edit-profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../auth/models/user.dart';
import '../../../../../auth/repos/user-helper.dart';
import '../../../../../auth/ui/screens/splash/splash.dart';
import '../../../../../home/ui/screens/home/widgets/custom-indicator.dart';
import '../../edit-profile/provider.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: UserHelper.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data == true) {
          return FutureBuilder<User?>(
            future: UserHelper.getUser(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (userSnapshot.hasData) {
                User user = userSnapshot.data!;
                final provider =
                    Provider.of<EditProfileProvider>(context, listen: false);
                return FutureBuilder(
                    future: provider.getProfile(userId: user.id ?? 0),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomCircularProgressIndicator();
                      }
                      final profile = snapshot.data;
                      return Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0.sp),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfileScreen(
                                          profilePicPath:
                                              profile?.profilePicture ?? ""))),
                              child: SvgPicture.asset(
                                editProfileIcon,
                                height: 30.h,
                                width: 30.w,
                              ),
                            ),
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                profile?.username ?? "",
                                style: GoogleFonts.tajawal(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                profile?.email ?? '',
                                style: GoogleFonts.tajawal(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.w),
                          CircleAvatar(
                            radius: 30.r,
                            backgroundColor: Colors.white,
                            backgroundImage: profile?.profilePicture != null
                                ? NetworkImage(profile?.profilePicture ?? '')
                                : AssetImage(""),
                          ),
                        ],
                      );
                    });
              }

              return Center(child: Text("Error loading user data"));
            },
          );
        } else {
          return GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, LoginScreen.id),
            child: Row(
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
                    width: 60.r,
                    height: 60.r,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

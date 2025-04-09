import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:Levant_Sale/src/modules/main/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';
import '../login/login.dart';
import '../sign-up/sign-up.dart';

class SplashScreen extends StatelessWidget {
  static const id = '/splash';

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: kprimaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 155.h,
                    ),
                    Text(
                      "اهلا بعودتك!",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26.sp),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                      child: Text(
                          "استمتع بتجربة تسوق فريدة انشر منتجاتك واشتري\nبكل سهولة",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: greySplash, fontSize: 14.sp)),
                    ),
                    SizedBox(
                      height: 64.h,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 360.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 32.h),
                    CustomElevatedButton(
                      text: "تسجيل دخول",
                      onPressed: () =>
                          Navigator.pushNamed(context, LoginScreen.id),
                      backgroundColor: kprimaryColor,
                      textColor: grey9,
                      date: false,
                    ),
                    SizedBox(height: 16.h),
                    CustomElevatedButton(
                      text: "الاستمرار كضيف",
                      onPressed: () =>
                          Navigator.pushNamed(context, MainScreen.id),
                      backgroundColor: grey8,
                      textColor: kprimaryColor,
                      date: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

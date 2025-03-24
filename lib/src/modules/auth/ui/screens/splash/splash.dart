import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
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
              flex: 1,
              child: Container(
                width: double.infinity,
                color: kprimaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    Text(
                      "أهلا بعودتك!",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp),
                    ),
                    SizedBox(height: 14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                      child: Text(
                          "استمتع بتجربة تسوق فريدة واشتر منتجاتك بكل سهولة",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: grey7)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      text: "تسجيل دخول",
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, LoginScreen.id),
                      backgroundColor: kprimaryColor,
                      textColor: Colors.white,
                      date: false,
                    ),
                    SizedBox(height: 16.h),
                    CustomElevatedButton(
                      text: "الاستمرار كضيف",
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, SignUpScreen.id),
                      backgroundColor: Colors.white,
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

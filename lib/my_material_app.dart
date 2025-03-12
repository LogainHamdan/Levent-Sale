import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tajawal/src/config/constants.dart';
import 'package:tajawal/src/modules/auth/ui/screens/login/login.dart';
import 'package:tajawal/src/modules/auth/ui/screens/sign-up/sign-up.dart';
import 'package:tajawal/src/modules/auth/ui/screens/splash/splash.dart';
import 'package:tajawal/src/modules/auth/ui/screens/verify/verify.dart';
import 'package:tajawal/src/modules/home/ui/screens/ads/ads.dart';
import 'package:tajawal/src/modules/home/ui/screens/evaluation/evaluations.dart';
import 'package:tajawal/src/modules/home/ui/screens/home/home.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            navigatorKey: GlobalKey<NavigatorState>(),
            debugShowCheckedModeBanner: false,
            title: 'Levent Sale',
            theme: ThemeData(
              textTheme: TextTheme(
                bodySmall: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w100,
                  color: grey5,
                  fontSize: 12,
                ),
                bodyMedium: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w500,
                  color: grey0,
                  fontSize: 18,
                ),
                bodyLarge: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w700,
                  color: grey0,
                  fontSize: 22,
                ),
              ),
            ),
            initialRoute: ReviewsScreen.id,
            routes: {
              SplashScreen.id: (context) => SplashScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              SignUpScreen.id: (context) => SignUpScreen(),
              VerificationScreen.id: (context) => VerificationScreen(),
              HomeScreen.id: (context) => HomeScreen(),
              AdsScreen.id: (context) => AdsScreen(),
              ReviewsScreen.id: (context) => ReviewsScreen(),
            },
          );
        });
  }
}

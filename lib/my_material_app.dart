import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/sign-up.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/splash.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/verify/verify.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/chats.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/evaluations.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
                bodyMedium: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                bodyLarge: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
            initialRoute: ChatListScreen.id,
            routes: {
              SplashScreen.id: (context) => SplashScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              SignUpScreen.id: (context) => SignUpScreen(),
              VerificationScreen.id: (context) => VerificationScreen(),
              HomeScreen.id: (context) => HomeScreen(),
              AdsScreen.id: (context) => AdsScreen(),
              ReviewsScreen.id: (context) => ReviewsScreen(),
              AdDetailsScreen.id: (context) => AdDetailsScreen(),
              ChatListScreen.id: (context) => ChatListScreen(),
            },
          );
        });
  }
}

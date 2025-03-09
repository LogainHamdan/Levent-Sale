import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart/';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tajawal/src/config/constants.dart';
import 'package:tajawal/src/modules/auth/ui/screens/splash.dart';

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
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: Locale('en'),
          title: 'Levent Sale',
          builder: (context, child) {
            return Theme(
                data: ThemeData(
                  fontFamily: 'Tajawal',
                  iconTheme: IconThemeData(color: grey0),
                  textTheme: TextTheme(
                    bodySmall: TextStyle(
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w400,
                      color: grey5,
                      fontSize: 12,
                    ),
                    bodyMedium: TextStyle(
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w500,
                      color: grey0,
                      fontSize: 18,
                    ),
                    bodyLarge: TextStyle(
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w700,
                      color: grey0,
                      fontSize: 22,
                    ),
                  ),
                  appBarTheme: AppBarTheme(backgroundColor: grey8),
                  scaffoldBackgroundColor: grey9, //
                  colorScheme: ColorScheme.fromSeed(seedColor: kprimaryColor),
                  useMaterial3: true,
                ),
                child: SplashScreen());
          },
          initialRoute: SplashScreen.id,
          routes: {},
        );
      },
    );
  }
}

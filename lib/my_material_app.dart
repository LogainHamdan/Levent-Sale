import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            // localizationsDelegates: context.localizationDelegates,
            // supportedLocales: context.supportedLocales,
            // locale: Locale('en'),
            title: 'Levent Sale',
            builder: (ctx, child) {
              ScreenUtil.init(ctx);
              return Theme(
                  data: ThemeData(
                    textTheme: TextTheme(
                      bodySmall: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w400,
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
                  child: SplashScreen());
            },
            initialRoute: SplashScreen.id,
            routes: {SplashScreen.id: (context) => SplashScreen()},
          );
        });
  }
}

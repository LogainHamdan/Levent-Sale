import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/sign-up.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/splash.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/verify/verify.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/chats.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/evaluations.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/notifications/notifications.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search-filter/search-filter.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/choose-section.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/creted-ad-details/created-ad-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/one-section.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/sections/sections.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/track-section/track-section-branches.dart';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/modules/sections/ui/screens/collection/my-collection.dart';

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
            localizationsDelegates: const [
              FlutterQuillLocalizations.delegate,
            ],
            navigatorKey: GlobalKey<NavigatorState>(),
            debugShowCheckedModeBanner: false,
            title: 'Levent Sale',
            theme: ThemeData(
              textTheme: TextTheme(
                bodySmall:
                    GoogleFonts.tajawal(fontSize: 16.sp, color: Colors.black),
                bodyMedium: GoogleFonts.tajawal(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.black),
                bodyLarge: GoogleFonts.tajawal(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: Colors.black),
              ),
            ),
            initialRoute: MyCollectionScreen.id,
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
              ConversationScreen.id: (context) =>
                  ConversationScreen(msgsAvailable: true),
              Section.id: (context) => Section(),
              NotificationsScreen.id: (context) => NotificationsScreen(
                    noData: false,
                  ),
              MyCollectionScreen.id: (context) => MyCollectionScreen(
                    empty: false,
                  ),
              CreateAdScreen.id: (context) => CreateAdScreen(),
              SectionTrack.id: (context) => SectionTrack(
                    cardListIndex: 0,
                  ),
              FilterScreen.id: (context) => FilterScreen(
                    cardListIndex: 0,
                  ),
              SectionDetails.id: (context) => SectionDetails(),
              AdCreatedDetails.id: (context) => AdCreatedDetails(),
              SectionChoose.id: (context) => SectionChoose(),
              Sections.id: (context) => Sections(),
            },
          );
        });
  }
}

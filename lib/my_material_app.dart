import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/logo/logo.dart';
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
import 'package:Levant_Sale/src/modules/home/ui/screens/search/search.dart';
import 'package:Levant_Sale/src/modules/main/ui/screens/main_screen.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/widgets/change-pass-column.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/delete-account/delete-account.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/delete-account/why-to-delete.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/edit-profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/fav-collection-screen/fav-collection-screen.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/favorite.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/followers.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/following.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/join-follow.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/friend-profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/tech-support-screen.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/technical-support.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/choose-section.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/one-section.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details1.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/sections/sections.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/track-section/track-section-branches.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/update-ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'src/modules/sections/ui/screens/collection/my-collection.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavoriteProvider>();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: MaterialApp(
            localizationsDelegates: const [
              FlutterQuillLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Levent Sale',
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                scrolledUnderElevation: 0,
                centerTitle: true,
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: Colors.transparent,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              primaryColor: kprimaryColor,
              textTheme: TextTheme(
                bodySmall: GoogleFonts.tajawal(
                  fontSize: 16.sp,
                ),
                bodyMedium: GoogleFonts.tajawal(
                  fontSize: 16.sp,
                ),
                bodyLarge: GoogleFonts.tajawal(
                    fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            initialRoute: LogoScreen.id,
            routes: {
              LogoScreen.id: (context) => LogoScreen(),
              SplashScreen.id: (context) => SplashScreen(),
              MainScreen.id: (context) => MainScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              SignUpScreen.id: (context) => SignUpScreen(),
              SupportScreen.id: (context) => SupportScreen(),
              //     VerificationScreen.id: (context) => VerificationScreen(),
              HomeScreen.id: (context) => HomeScreen(),
              AdsScreen.id: (context) => AdsScreen(),
              ReviewsScreen.id: (context) => ReviewsScreen(),
              AdDetailsScreen.id: (context) => AdDetailsScreen(
                    adId: 0,
                  ),
              ChatListScreen.id: (context) => ChatListScreen(),
              ConversationScreen.id: (context) => ConversationScreen(
                    adId: 0,
                    userId: 0,
                    receiverId: 0,
                  ),
              Section.id: (context) => Section(),
              NotificationsScreen.id: (context) => NotificationsScreen(
                    noData: false,
                  ),
              MyCollectionScreen.id: (context) => MyCollectionScreen(),
              FavoriteScreen.id: (context) => FavoriteScreen(),
              CreateAdScreen.id: (context) => CreateAdScreen(
                    lowerWidget: SectionChoose(
                      create: true,
                    ),
                  ),
              UpdateAdScreen.id: (context) => UpdateAdScreen(
                    adId: 0,
                    lowerWidget: SectionChoose(
                      create: false,
                    ),
                  ),
              FilterScreen.id: (context) => FilterScreen(
                    cardListIndex: 0,
                  ),
              Sections.id: (context) => Sections(),
              MenuScreen.id: (context) => MenuScreen(),
              EditProfileScreen.id: (context) => EditProfileScreen(),
              TechnicalSupportScreen.id: (context) => TechnicalSupportScreen(),
              ProfileScreen.id: (context) => const ProfileScreen(),
              FriendProfile.id: (context) {
                return FriendProfile(
                  userId: 0,
                );
              },
              FollowingScreen.id: (context) => FollowingScreen(),
              FollowersScreen.id: (context) => FollowersScreen(),
              JoinFollow.id: (context) => JoinFollow(
                    userId: 0,
                  ),
              WhyToDeleteScreen.id: (context) => WhyToDeleteScreen(),
              SearchScreen.id: (context) => SearchScreen(),
              FavoriteCollectionScreen.id: (context) =>
                  FavoriteCollectionScreen(
                    tagId: favProvider.selectedTag!.id ?? '',
                  ),
              DeleteAccountScreen.id: (context) => DeleteAccountScreen(
                    phase1email: true,
                  ),
              ChangePassColumn.id: (context) => ChangePassColumn(
                    alert: false,
                  ),
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => MainScreen(),
              );
            },
          ),
        );
      },
    );
  }
}

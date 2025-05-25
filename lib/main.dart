import 'dart:io';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/managers/firebase_messaging_manager.dart';
import 'package:Levant_Sale/src/managers/local_notifications_manager.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/verify/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/notifications/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search/provider.dart';
import 'package:Levant_Sale/src/modules/main/ui/screens/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/delete-account/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'my_material_app.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  await FirebaseMessagingManager.instance.init();
  await LocalNotificationsManager.instance.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => SignUpProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => VerificationProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => HomeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => AdDetailsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ChatProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => EvaluationProvider(4.4),
      ),
      ChangeNotifierProvider(
        create: (_) => CreateAdProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => UpdateAdProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CreateAdSectionDetailsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => UpdateAdSectionDetailsProvider(context),
      ),
      ChangeNotifierProvider(
        create: (_) => TechSupportProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => MyCollectionScreenProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => MenuProvider(),
      ),
      ChangeNotifierProvider(create: (context) => EditProfileProvider()),
      ChangeNotifierProvider(
        create: (context) => FollowProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => DeleteScreenProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ConversationProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => BottomNavProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SearchProvider(),
      ),
      Provider<RouteObserver<ModalRoute<dynamic>>>(
          create: (_) => RouteObserver<ModalRoute<dynamic>>()),
      ChangeNotifierProvider(
        create: (context) => CreateAdChooseSectionProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => UpdateAdProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => UpdateAdSectionDetailsProvider(context),
      ),
      ChangeNotifierProvider(
        create: (context) => FavoriteProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => NotificationProvider(),
      ),
    ], child: MyMaterialApp());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

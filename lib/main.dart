import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/verify/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search/provider.dart';
import 'package:Levant_Sale/src/modules/main/ui/screens/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/delete-account/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/update-ad-choose-section.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/create-ad-section-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/update-ad-section-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'my_material_app.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
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
        create: (_) => EvaluationProvider(4.4),
      ),
      ChangeNotifierProvider(
        create: (_) => CreateAdProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CreateAdSectionDetailsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => UpdateAdSectionDetailsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProfileProvider(),
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
      ChangeNotifierProvider(
        create: (context) => CreateAdChooseSectionProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => UpdateAdChooseSectionProvider(),
      ),
    ], child: MyMaterialApp());
  }
}

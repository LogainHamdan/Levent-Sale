import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/verify/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/delete-account/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/provider.dart';
import 'package:Levant_Sale/src/modules/nav-bar/nav_provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/creted-ad-details/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'my_material_app.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => NavigationProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => RegisterProvider(),
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
        create: (_) => StepperProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => PropertyFormProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => EditorProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => TabProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => MenuProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => EditProfileProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => FollowProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => DeleteProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ConversationProvider(),
      ),
    ], child: MyMaterialApp());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tajawal/my_material_app.dart';
import 'package:tajawal/src/modules/auth/ui/screens/login/provider.dart';
import 'package:tajawal/src/modules/auth/ui/screens/sign-up/provider.dart';
import 'package:tajawal/src/modules/auth/ui/screens/splash/splash.dart';
import 'package:tajawal/src/modules/auth/ui/screens/verify/provider.dart';
import 'package:tajawal/src/modules/home/ui/screens/home/provider.dart';
import 'package:tajawal/src/modules/nav-bar/nav_provider.dart';

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
    ], child: MyMaterialApp());
  }
}

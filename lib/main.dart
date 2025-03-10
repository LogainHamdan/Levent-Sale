import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tajawal/my_material_app.dart';
import 'package:tajawal/src/modules/auth/ui/screens/splash.dart';
import 'package:tajawal/src/modules/nav-bar/nav_provider.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  // WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();

  runApp(MyApp()
      // EasyLocalization(
      //   supportedLocales: [
      //     Locale('en', 'US'),
      //     Locale('ar', 'EG')
      //   ], // Add other supported locales as needed
      //   fallbackLocale: Locale('en', 'US'),
      //   path: '',
      //   child: const MyApp(),
      // ),
      );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ], child: MyMaterialApp());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tajawal/src/modules/nav-bar/custom_nav_bar.dart';

class SplashScreen extends StatelessWidget {
  static const id = '/splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          SizedBox(
            height: 60,
          ),
          CustomBottomNavigationBar()
        ],
      ),
    );
  }
}

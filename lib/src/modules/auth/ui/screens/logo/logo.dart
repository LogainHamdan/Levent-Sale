import 'dart:async';

import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../main/ui/screens/main_screen.dart';
import '../../../../sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import '../../../repos/token-helper.dart';
import '../splash/splash.dart';

class LogoScreen extends StatefulWidget {
  static const id = '/logo';

  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
    _startLogoTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startLogoTimer() {
    Timer(const Duration(seconds: 4), _startApp);
  }

  Future<void> _startApp() async {
    final token = await TokenHelper.getToken();
    final provider =
        Provider.of<CreateAdChooseSectionProvider>(context, listen: false);
    await provider.fetchCategories();
    if (token == null) {
      Navigator.pushReplacementNamed(context, SplashScreen.id);
    } else {
      Navigator.pushReplacementNamed(context, MainScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [grey8, grey5],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0.w),
                  child: Image.asset(logo),
                ),
                SizedBox(height: 20.h),
                CircularProgressIndicator(
                  color: kprimaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

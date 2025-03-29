import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/verify/widgets/code-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../main/ui/screens/main_screen.dart';
import '../login/widgets/or-row.dart';
import '../login/widgets/instead-widget.dart';
import '../splash/widgets/custom-elevated-button.dart';

class VerificationScreen extends StatelessWidget {
  static const id = '/verify';

  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 90.h, bottom: 50.h),
                child: Center(
                  child: Text(
                    "تسجيل جديد",
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: kprimaryColor),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0.sp),
                child: Text(
                  "ادخل رمز التحقق",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(right: 8.0.sp),
                child: Text(
                  "المرسل على الإيميل minnabasim12@gmail.com",
                  style: TextStyle(fontSize: 14.sp, color: grey4),
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 350.w,
                child: CodeRow(),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: Text(
                  "إعادة ارسال",
                  style: TextStyle(
                    color: kprimaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomElevatedButton(
                  text: 'تحقق',
                  onPressed: () => Navigator.pushNamed(context, MainScreen.id),
                  backgroundColor: kprimaryColor,
                  textColor: grey9,
                  date: false),
              SizedBox(height: 20.h),
              OrRow(),
              SizedBox(height: 14.h),
              Center(
                  child: InsteadWidget(
                      route: LoginScreen.id,
                      question: 'هل لديك حساب؟',
                      action: 'سجل دخول'))
            ],
          ),
        ),
      ),
    );
  }
}

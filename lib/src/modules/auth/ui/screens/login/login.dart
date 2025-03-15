import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/alert.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/or-row.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/social-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../splash/widgets/custom-elevated-button.dart';

class LoginScreen extends StatelessWidget {
  static const id = '/login';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Text("تسجيل دخول",
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: kprimaryColor,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 30.h),
                TextField(
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 12.sp),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: grey8,
                    hintStyle: TextStyle(
                      color: grey4,
                      fontSize: 14.sp,
                    ),
                    hintText: "البريد الإلكتروني / رقم الجوال",
                    hintTextDirection: TextDirection.rtl,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) {
                    return TextField(
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 12.sp),
                      obscureText: !loginProvider.passwordVisible,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: grey8,
                        hintStyle: TextStyle(
                          color: grey4,
                          fontSize: 16.sp,
                        ),
                        hintText: "كلمة المرور",
                        hintTextDirection: TextDirection.rtl,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.all(12.0.sp),
                            child: Image.asset(
                              loginProvider.passwordVisible
                                  ? 'assets/imgs_icons/auth/assets/icons/seen.png'
                                  : 'assets/imgs_icons/auth/assets/icons/unseen.png',
                              height: 1.h,
                            ),
                          ),
                          onTap: loginProvider.togglePasswordVisibility,
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0.w),
                      child: GestureDetector(
                        onTap: () => showForgotPassword(context),
                        child: Text("نسيت كلمة المرور ؟",
                            style: TextStyle(
                                color: Colors.orange, fontSize: 14.sp)),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "تذكرني",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) {
                        return Checkbox(
                          value: loginProvider.rememberMe,
                          onChanged: loginProvider.toggleRememberMe,
                          fillColor: MaterialStateProperty.all(
                            loginProvider.rememberMe
                                ? kprimaryColor
                                : Colors.white,
                          ),
                          checkColor: Colors.white,
                          activeColor: kprimaryColor,
                          focusColor: kprimaryColor,
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 16),
                CustomElevatedButton(
                  notText: true,
                  text: 'متابعة',
                  onPressed: () {},
                  backgroundColor: kprimaryColor,
                  textColor: Colors.white,
                  date: false,
                ),
                SizedBox(height: 16.h),
                OrRow(),
                SizedBox(height: 16.h),
                SocialButton(
                    facebook: false,
                    text: "الاستمرار بجوجل Google",
                    image: 'assets/imgs_icons/auth/assets/imgs/google.png'),
                SizedBox(height: 8.h),
                SocialButton(
                    facebook: true,
                    text: "الاستمرار بالفيسبوك Facebook",
                    image: 'assets/imgs_icons/auth/assets/imgs/facebook.png',
                    color: Colors.blue),
                SizedBox(height: 16.h),
                Text.rich(
                  TextSpan(
                    text: "ليس لديك حساب؟ ",
                    children: [
                      TextSpan(
                        text: " سجل الآن",
                        style: TextStyle(
                            color: kprimaryColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

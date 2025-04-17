import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';

import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/checkbox.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/instead-widget.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/or-row.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/social-button.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/sign-up.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../config/constants.dart';
import 'package:provider/provider.dart';
import '../../../repos/token-helper.dart';
import '../splash/widgets/custom-elevated-button.dart';

class LoginScreen extends StatelessWidget {
  static const id = '/loginId';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 48.h),
                  Text(
                    "تسجيل دخول",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  Consumer<LoginProvider>(
                      builder: (context, authProvider, child) {
                    return CustomTextField(
                      isRequired: true,
                      errorText: authProvider.hasTriedSubmit &&
                              authProvider.emailController.text.trim().isEmpty
                          ? 'يجب عليك ادخال بريد الكتروني صحيح'
                          : null,
                      bgcolor: grey8,
                      controller: authProvider.emailController,
                      hint: 'البريد الالكتروني / رقم الجوال',
                    );
                  }),
                  SizedBox(height: 16.h),
                  Consumer<LoginProvider>(
                      builder: (context, authProvider, child) {
                    return CustomPasswordField(
                      isConfirmField: false,
                      controller: authProvider.passwordController,
                      hint: 'كلمة المرور',
                    );
                  }),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => showForgotPassword(context),
                        child: Text(
                          "نسيت كلمة المرور ؟",
                          style: TextStyle(
                            color: Color(0xffF75555),
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      Spacer(),
                      Consumer<LoginProvider>(
                          builder: (context, loginProvider, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'تذكرني',
                              style: GoogleFonts.tajawal(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            CustomCheckBox(
                              title: "",
                              value: loginProvider.rememberMe,
                              onChanged: (value) =>
                                  loginProvider.toggleRememberMe(value),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) {
                    return CustomElevatedButton(
                      text: 'متابعة',
                      onPressed: () {
                        print("Login button pressed!");

                        loginProvider.markTriedSubmit();
                        loginProvider.loginUser(
                            context: context,
                            identifier: loginProvider.emailController.text,
                            password: loginProvider.passwordController.text);
                        print("Login button applied!");
                      },
                      backgroundColor: kprimaryColor,
                      textColor: grey9,
                      date: false,
                    );
                  }),
                  SizedBox(height: 8.h),
                  OrRow(),
                  SizedBox(height: 8.h),
                  Consumer<LoginProvider>(
                      builder: (context, authProvider, child) {
                    return SocialButton(
                      facebook: false,
                      onPressed: () {
                        print("Google login button pressed.");
                        authProvider.googleLogin(context);
                      },
                      text: "الاستمرار بجوجل Google",
                      image: googlePath,
                    );
                  }),
                  SizedBox(height: 8.h),
                  SocialButton(
                    facebook: true,
                    onPressed: () {},
                    text: "الاستمرار بالفيسبوك Facebook",
                    image: facebookPath,
                  ),
                  SizedBox(height: 16.h),
                  InsteadWidget(
                    route: SignUpScreen.id,
                    question: "ليس لديك حساب؟ ",
                    action: 'سجل الآن',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

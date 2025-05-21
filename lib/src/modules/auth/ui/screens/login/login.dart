import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';

import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/checkbox.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/instead-widget.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/or-row.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/social-button.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/sign-up.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:Levant_Sale/src/modules/main/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    return Consumer<LoginProvider>(
      builder: (context, provider, child) => Scaffold(
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
                  CustomTextField(
                    isRequired: true,
                    errorText: provider.hasTriedSubmit &&
                            provider.emailController.text.trim().isEmpty
                        ? 'يجب عليك ادخال بريد الكتروني صحيح'
                        : null,
                    bgcolor: grey8,
                    controller: provider.emailController,
                    hint: 'البريد الالكتروني / رقم الجوال',
                  ),
                  SizedBox(height: 16.h),
                  CustomPasswordField(
                    login: true,
                    errorText: provider.passwordError,
                    isConfirmField: false,
                    controller: provider.passwordController,
                    hint: 'كلمة المرور',
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => showForgotPassword(context),
                        child: Text(
                          "نسيت كلمة المرور ؟",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xffF75555),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Spacer(),
                      CustomCheckBox(
                        title: Text(
                          'تذكرني',
                          style: GoogleFonts.tajawal(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: provider.rememberMe,
                        onChanged: (value) => provider.toggleRememberMe(value),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CustomElevatedButton(
                    text: 'متابعة',
                    onPressed: () async {
                      print("Login button pressed!");
                      provider.markTriedSubmit();
                      provider.validateFields();
                      if (!provider.isFormValid) {
                        print("Form is not valid. Please check your inputs.");
                        return;
                      }

                      await provider.loginUser(
                        context: context,
                        identifier: provider.emailController.text.trim(),
                        password: provider.passwordController.text.trim(),
                      );

                      String? token = await TokenHelper.getToken();
                      print('Token: $token');
                      if (token != null && token.isNotEmpty) {
                        Navigator.pushReplacementNamed(
                          context,
                          MainScreen.id,
                        );
                      } else {
                        print("Login failed: token not available.");
                      }
                    },
                    backgroundColor: kprimaryColor,
                    textColor: grey9,
                    date: false,
                  ),
                  SizedBox(height: 8.h),
                  OrRow(),
                  SizedBox(height: 8.h),
                  SocialButton(
                    facebook: false,
                    onPressed: () async {
                      provider.handleGoogleSignIn();
                      // final GoogleSignIn _googleSignIn = GoogleSignIn(
                      //   scopes: ['openid' 'email', 'profile'],
                      //   clientId:
                      //       '846139057206-h2t2convvg0hp11dasev7707pq6kro0m.apps.googleusercontent.com',
                      // );

                      // try {
                      //   final GoogleSignInAccount? googleUser =
                      //       await _googleSignIn.signIn();
                      //   if (googleUser == null) {
                      //     print('User cancelled sign-in');
                      //     return;
                      //   }
                      //
                      //   final googleAuth = await googleUser.authentication;
                      //   final idToken = googleAuth.idToken;
                      //   print('ID token is $idToken');
                      //
                      //   if (idToken == null) {
                      //     print('ID token is null!');
                      //     return;
                      //   }
                      //
                      //   await provider.googleLogin(idToken);
                      //   print('Signed in with token: $idToken');
                      // } catch (error) {
                      //   print('Google Sign-In error: $error');
                      // }
                    },
                    text: "الاستمرار بجوجل Google",
                    image: googlePath,
                  ),
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

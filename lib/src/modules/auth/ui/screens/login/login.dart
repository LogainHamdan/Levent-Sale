import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/repos/google-login-repo.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/repos/login-repo.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/repos/logout-repo.dart';
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
import '../../../../../config/constants.dart';
import 'package:provider/provider.dart';
import '../splash/widgets/custom-elevated-button.dart';

class LoginScreen extends StatelessWidget {
  static const id = '/loginId';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
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
                  Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                    return CustomTextField(
                      bgcolor: grey8,
                      controller: authProvider.emailController,
                      hint: 'البريد الالكتروني / رقم الجوال',
                      onChanged: (_) => _updateButtonState(context),
                    );
                  }),
                  SizedBox(height: 16.h),
                  Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                    return CustomPasswordField(
                      isConfirmField: false,
                      controller: authProvider.passwordController,
                      hint: 'كلمة المرور',
                      onChanged: (_) => _updateButtonState(context),
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
                      Consumer<AuthProvider>(
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
                  Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                    return CustomElevatedButton(
                      text: 'متابعة',
                      onPressed: () => authProvider.isFormValid
                          ? () => _handleLogin(context)
                          : null,
                      backgroundColor: kprimaryColor,
                      textColor: grey9,
                      date: false,
                    );
                  }),
                  SizedBox(height: 8.h),
                  OrRow(),
                  SizedBox(height: 8.h),
                  Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                    return SocialButton(
                      facebook: false,
                      onPressed: () => authProvider.googleLogin(context),
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

  void _updateButtonState(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool isFormValid = authProvider.emailController.text.isNotEmpty &&
        authProvider.passwordController.text.isNotEmpty;
    authProvider.setFormValid(isFormValid);
  }

  Future<void> _handleLogin(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loginUser(
      context: context,
      identifier: authProvider.emailController.text.trim(),
      password: authProvider.passwordController.text.trim(),
      recaptchaToken: 'default_trust_chain',
    );
  }
}

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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
                CustomTextField(
                    bgcolor: grey8,
                    controller: TextEditingController(),
                    hint: 'البريد الالكتروني /الاسم كاملاً'),
                SizedBox(height: 16.h),
                CustomPasswordField(
                    isConfirmField: false,
                    controller: TextEditingController(),
                    hint: 'كلمة المرور'),
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
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) {
                        return Row(
                          children: [
                            Text(
                              'تذكرني',
                              style: GoogleFonts.tajawal(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            CustomCheckBox(
                              title: "",
                              value: loginProvider.rememberMe,
                              onChanged: (value) =>
                                  loginProvider.toggleRememberMe(value),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 16),
                CustomElevatedButton(
                  notText: true,
                  text: 'متابعة',
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, HomeScreen.id),
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
                InsteadWidget(
                    route: SignUpScreen.id,
                    question: "ليس لديك حساب؟ ",
                    action: 'سجل الآن')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

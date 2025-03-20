import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-dropdowm.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/phone-section.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../config/constants.dart';
import '../../alerts/alert.dart';
import '../login/widgets/instead-widget.dart';
import '../login/widgets/or-row.dart';
import '../login/widgets/social-button.dart';
import '../splash/widgets/custom-elevated-button.dart';

class SignUpScreen extends StatelessWidget {
  static const id = '/register';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80.h),
                Text(
                  "تسجيل جديد",
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.h),
                CustomTextField(
                  bgcolor: grey8,
                  controller: TextEditingController(),
                  hint: "الاسم كاملاً",
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  bgcolor: grey8,
                  controller: TextEditingController(),
                  hint: "البريد الإلكتروني",
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                CustomPasswordField(
                  isConfirmField: false,
                  controller: TextEditingController(),
                  hint: "كلمة المرور",
                ),
                SizedBox(height: 16.h),
                CustomPasswordField(
                  isConfirmField: true,
                  controller: TextEditingController(),
                  hint: "تأكيد كلمة المرور",
                ),
                SizedBox(height: 16.h),
                SizedBox(height: 16.h),
                PhoneSection(),
                SizedBox(height: 16.h),
                CustomDropdown(
                  items: ["مستخدم", "مزود خدمة"],
                  hint: "اختر نوع الحساب",
                ),
                SizedBox(height: 16.h),
                Consumer<RegisterProvider>(
                  builder: (context, registerProvider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "الشروط والخصوصية ",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "موافق على",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                          value: registerProvider.agreeToTerms,
                          onChanged: registerProvider.toggleAgreement,
                          activeColor: kprimaryColor,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16.h),
                CustomElevatedButton(
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
                  image: 'assets/imgs_icons/auth/assets/imgs/google.png',
                ),
                SizedBox(height: 8.h),
                SocialButton(
                  facebook: true,
                  text: "الاستمرار بالفيسبوك Facebook",
                  image: 'assets/imgs_icons/auth/assets/imgs/facebook.png',
                  color: Colors.blue,
                ),
                SizedBox(height: 16.h),
                InsteadWidget(
                  question: 'هل لديك حساب؟',
                  action: 'سجل دخول',
                  route: LoginScreen.id,
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

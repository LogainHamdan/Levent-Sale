import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-dropdowm.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/login-instead.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/phone-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../alerts/alert.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Text(
                  "تسجيل جديد",
                  style: TextStyle(
                    fontSize: 25,
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: TextEditingController(),
                  hint: "الاسم كاملاً",
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: TextEditingController(),
                  hint: "البريد الإلكتروني",
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                CustomPasswordField(
                  controller: TextEditingController(),
                  hint: "كلمة المرور",
                ),
                SizedBox(height: 16.h),
                CustomPasswordField(
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
                  notText: false,
                  text: 'متابعة',
                  onPressed: () => showDatePickerDialog(context),
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
                LoginInsteadWidget(),
                SizedBox(
                  height: 12.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

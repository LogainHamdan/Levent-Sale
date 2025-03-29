import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-dropdowm.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/phone-section.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/verify/verify.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../config/constants.dart';
import '../../alerts/alert.dart';
import '../login/widgets/instead-widget.dart';
import '../login/widgets/or-row.dart';
import '../login/widgets/social-button.dart';
import '../splash/widgets/custom-elevated-button.dart';

class SignUpScreen extends StatelessWidget {
  static const id = '/register';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController = TextEditingController(
        text: DateFormat('MMMM dd, yyyy').format(DateTime.now()));
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  Text(
                    "تسجيل جديد",
                    style: TextStyle(
                      fontSize: 25.sp,
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    bgcolor: grey8,
                    controller: TextEditingController(),
                    hint: "الاسم كاملاً",
                  ),
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
                  SizedBox(height: 18.h),
                  PhoneSection(),
                  SizedBox(height: 18.h),
                  CustomDropdown(
                    items: ["شخصي", "شركة"],
                    hint: "اختر نوع الحساب",
                  ),
                  Consumer<RegisterProvider>(
                    builder: (context, provider, child) {
                      if (provider.selectedValue == "شخصي") {
                        return Column(
                          children: [
                            CustomTextField(
                              prefix: GestureDetector(
                                onTap: () => showDatePickerDialog(
                                    context, dateController),
                                child: Icon(Icons.calendar_month_outlined,
                                    color: grey0),
                              ),
                              controller: dateController,
                              bgcolor: grey8,
                              hint: 'تاريخ الميلاد',
                            ),
                          ],
                        );
                      } else if (provider.selectedValue == "شركة") {
                        return Column(
                          children: [
                            CustomTextField(
                              prefix: GestureDetector(
                                onTap: () => showDatePickerDialog(
                                    context, dateController),
                                child: Icon(Icons.calendar_month_outlined,
                                    color: grey0),
                              ),
                              controller: dateController,
                              bgcolor: grey8,
                              hint: 'تاريخ انشاء الشركة',
                            ),
                            CustomTextField(
                              bgcolor: grey8,
                              controller: TextEditingController(),
                              hint: "عنوان الشركة",
                            ),
                            CustomTextField(
                              bgcolor: grey8,
                              controller: TextEditingController(),
                              hint: "الرقم الضريبي",
                            ),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
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
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, VerificationScreen.id),
                    backgroundColor: kprimaryColor,
                    textColor: grey9,
                    date: false,
                  ),
                  SizedBox(height: 16.h),
                  OrRow(),
                  SizedBox(height: 16.h),
                  SocialButton(
                    facebook: false,
                    text: "الاستمرار بجوجل Google",
                    image: googlePath,
                  ),
                  SizedBox(height: 8.h),
                  SocialButton(
                    facebook: true,
                    text: "الاستمرار بالفيسبوك Facebook",
                    image: facebookPath,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 16.h),
                  InsteadWidget(
                    question: 'هل لديك حساب؟',
                    action: 'سجل دخول',
                    route: LoginScreen.id,
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

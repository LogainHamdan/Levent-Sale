import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-dropdowm.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/phone-section.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/verify/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final TextEditingController phoneController = TextEditingController();
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
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
                    "تسجيل جديد",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomDropdown(
                    items: ["شخصي", "شركة"],
                    hint: "اختر نوع الحساب",
                  ),
                  Consumer<RegisterProvider>(
                    builder: (context, provider, child) {
                      if (provider.selectedValue == "شخصي") {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    bgcolor: grey8,
                                    controller: TextEditingController(),
                                    hint: "ادخل الاسم",
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: CustomTextField(
                                    bgcolor: grey8,
                                    controller: TextEditingController(),
                                    hint: "ادخل الكنية",
                                  ),
                                ),
                              ],
                            ),
                            CustomTextField(
                              prefix: GestureDetector(
                                onTap: () => showDatePickerDialog(
                                    context, dateController),
                                child: SvgPicture.asset(
                                  calendarIcon,
                                  height: 20.h,
                                  width: 20.w,
                                ),
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
                              bgcolor: grey8,
                              controller: TextEditingController(),
                              hint: "اسم الشركة",
                            ),
                            CustomTextField(
                              prefix: GestureDetector(
                                onTap: () => showDatePickerDialog(
                                    context, dateController),
                                child: SvgPicture.asset(
                                  calendarIcon,
                                  height: 20.h,
                                  width: 20.w,
                                ),
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
                  PhoneSection(
                    controller: phoneController,
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
                          SizedBox(
                            width: 11.w,
                          ),
                          SizedBox(
                            height: 18.h,
                            width: 18.w,
                            child: Checkbox(
                              value: registerProvider.agreeToTerms,
                              onChanged: registerProvider.toggleAgreement,
                              activeColor: kprimaryColor,
                            ),
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

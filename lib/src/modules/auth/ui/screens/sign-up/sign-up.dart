import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-dropdowm.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/phone-section.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/verify/verify.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../config/constants.dart';
import '../../alerts/alert.dart';
import '../login/provider.dart';

import '../login/widgets/instead-widget.dart';
import '../login/widgets/or-row.dart';
import '../login/widgets/social-button.dart';
import '../splash/widgets/custom-elevated-button.dart';

class SignUpScreen extends StatelessWidget {
  static const id = '/register';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: SingleChildScrollView(
              child: Consumer<RegisterProvider>(
                builder: (context, provider, child) {
                  return Column(
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
                      if (provider.selectedValue == "شخصي") ...[
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                bgcolor: grey8,
                                controller: provider.firstNameController,
                                hint: "ادخل الاسم",
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: CustomTextField(
                                bgcolor: grey8,
                                controller: provider.lastNameController,
                                hint: "ادخل الكنية",
                              ),
                            ),
                          ],
                        ),
                        CustomTextField(
                          prefix: GestureDetector(
                            onTap: () => showDatePickerDialog(
                                context, provider.dateController),
                            child: SvgPicture.asset(
                              calendarIcon,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                          controller: provider.dateController,
                          bgcolor: grey8,
                          hint: 'تاريخ الميلاد',
                        ),
                      ] else if (provider.selectedValue == "شركة") ...[
                        CustomTextField(
                          bgcolor: grey8,
                          controller: provider.companyNameController,
                          hint: "اسم الشركة",
                        ),
                        CustomTextField(
                          prefix: GestureDetector(
                            onTap: () => showDatePickerDialog(
                                context, provider.dateController),
                            child: SvgPicture.asset(
                              calendarIcon,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                          controller: provider.dateController,
                          bgcolor: grey8,
                          hint: 'تاريخ انشاء الشركة',
                        ),
                        CustomTextField(
                          bgcolor: grey8,
                          controller: provider.companyAddressController,
                          hint: "عنوان الشركة",
                        ),
                        CustomTextField(
                          bgcolor: grey8,
                          controller: provider.taxNumberController,
                          hint: "الرقم الضريبي",
                        ),
                      ],
                      CustomTextField(
                        bgcolor: grey8,
                        controller: provider.emailController,
                        hint: "البريد الإلكتروني",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16.h),
                      CustomPasswordField(
                        isConfirmField: false,
                        controller: provider.passwordController,
                        hint: "كلمة المرور",
                      ),
                      SizedBox(height: 16.h),
                      CustomPasswordField(
                        isConfirmField: true,
                        controller: provider.confirmPasswordController,
                        hint: "تأكيد كلمة المرور",
                      ),
                      SizedBox(height: 16.h),
                      PhoneSection(
                        controller: provider.phoneController,
                      ),
                      SizedBox(height: 16.h),
                      Row(
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
                          SizedBox(width: 11.w),
                          SizedBox(
                            height: 18.h,
                            width: 18.w,
                            child: Checkbox(
                              value: provider.agreeToTerms,
                              onChanged: provider.toggleAgreement,
                              activeColor: kprimaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      CustomElevatedButton(
                        text: 'متابعة',
                        onPressed: () {
                          final provider = Provider.of<RegisterProvider>(
                              context,
                              listen: false);

                          final userData = {
                            "first_name": provider.firstNameController.text,
                            "last_name": provider.lastNameController.text,
                            "birth_date": provider.birthDateController.text,
                            "company_name": provider.companyNameController.text,
                            "company_date": provider.companyDateController.text,
                            "company_address":
                                provider.companyAddressController.text,
                            "tax_number": provider.taxNumberController.text,
                            "email": provider.emailController.text,
                            "password": provider.passwordController.text,
                            "phone": provider.phoneController.text,
                            "role": provider.selectedValue ?? "",
                          };

                          provider.registerUser(context, userData);
                        },
                        backgroundColor: kprimaryColor,
                        textColor: grey9,
                        date: false,
                      ),
                      SizedBox(height: 16.h),
                      OrRow(),
                      SizedBox(height: 16.h),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return SocialButton(
                            facebook: false,
                            onPressed: () => authProvider.googleLogin(context),
                            text: "الاستمرار بجوجل Google",
                            image: googlePath,
                          );
                        },
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
                        question: 'هل لديك حساب؟',
                        action: 'سجل دخول',
                        route: LoginScreen.id,
                      ),
                      SizedBox(height: 12.h),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

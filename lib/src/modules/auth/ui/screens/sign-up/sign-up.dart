import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/checkbox.dart';
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
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: SingleChildScrollView(
              child: Consumer<SignUpProvider>(
                builder: (context, provider, child) {
                  return SizedBox(
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
                          onChanged: (value) {
                            provider.setSelectedValue(value);
                          },
                        ),
                        SizedBox(height: 4.h),
                        if (provider.selectedValue == "شخصي") ...[
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  errorText: provider.hasTriedSubmit &&
                                          provider.firstNameController.text
                                              .trim()
                                              .isEmpty
                                      ? 'هذا الحقل مطلوب'
                                      : null,
                                  bgcolor: grey8,
                                  controller: provider.firstNameController,
                                  hint: "ادخل الاسم",
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: CustomTextField(
                                  errorText: provider.hasTriedSubmit &&
                                          provider.lastNameController.text
                                              .trim()
                                              .isEmpty
                                      ? 'هذا الحقل مطلوب'
                                      : null,
                                  bgcolor: grey8,
                                  controller: provider.lastNameController,
                                  hint: "ادخل الكنية",
                                ),
                              ),
                            ],
                          ),
                          CustomTextField(
                            isRequired: true,
                            errorText: provider.hasTriedSubmit &&
                                    provider.birthDateController.text
                                        .trim()
                                        .isEmpty
                                ? 'يجب عليك ادخال تاريخ ميلاد صحيح'
                                : null,
                            prefix: GestureDetector(
                              onTap: () => showDatePickerDialog(
                                  context, provider.birthDateController),
                              child: SvgPicture.asset(
                                calendarIcon,
                                height: 20.h,
                                width: 20.w,
                              ),
                            ),
                            controller: provider.birthDateController,
                            bgcolor: grey8,
                            hint: 'تاريخ الميلاد',
                          ),
                          SizedBox(height: 8.h),
                        ] else if (provider.selectedValue == "شركة") ...[
                          CustomTextField(
                            isRequired: true,
                            errorText: provider.hasTriedSubmit &&
                                    provider.companyNameController.text
                                        .trim()
                                        .isEmpty
                                ? 'هذا الحقل مطلوب'
                                : null,
                            bgcolor: grey8,
                            controller: provider.companyNameController,
                            hint: "اسم الشركة",
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CustomTextField(
                            isRequired: true,
                            errorText: provider.hasTriedSubmit &&
                                    provider.companyDateController.text
                                        .trim()
                                        .isEmpty
                                ? 'هذا الحقل مطلوب'
                                : null,
                            prefix: GestureDetector(
                              onTap: () => showDatePickerDialog(
                                  context, provider.companyDateController),
                              child: SvgPicture.asset(
                                calendarIcon,
                                height: 20.h,
                                width: 20.w,
                              ),
                            ),
                            controller: provider.companyDateController,
                            bgcolor: grey8,
                            hint: 'تاريخ انشاء الشركة',
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CustomTextField(
                            isRequired: true,
                            errorText: provider.hasTriedSubmit &&
                                    provider.companyAddressController.text
                                        .trim()
                                        .isEmpty
                                ? 'هذا الحقل مطلوب'
                                : null,
                            bgcolor: grey8,
                            controller: provider.companyAddressController,
                            hint: "عنوان الشركة",
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CustomTextField(
                            isRequired: true,
                            errorText: provider.hasTriedSubmit &&
                                    provider.taxNumberController.text
                                        .trim()
                                        .isEmpty
                                ? 'هذا الحقل مطلوب'
                                : null,
                            bgcolor: grey8,
                            controller: provider.taxNumberController,
                            hint: "الرقم الضريبي",
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                        ] else ...[
                          SizedBox.shrink()
                        ],
                        CustomTextField(
                          isRequired: true,
                          errorText: provider.emailError,
                          bgcolor: grey8,
                          controller: provider.emailController,
                          hint: "البريد الإلكتروني",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 8.h),
                        CustomPasswordField(
                          isConfirmField: false,
                          controller: provider.passwordController,
                          hint: "كلمة المرور",
                          errorText: provider.passwordError,
                        ),
                        SizedBox(height: 8.h),
                        CustomPasswordField(
                          isConfirmField: true,
                          controller: provider.confirmPasswordController,
                          hint: "تأكيد كلمة المرور",
                          errorText: provider.confirmPasswordError,
                        ),
                        SizedBox(height: 8.h),
                        PhoneSection(
                          controller: provider.phoneController,
                          errorText: provider.phoneError,
                        ),
                        SizedBox(height: 8.h),
                        CustomCheckBox(
                          errorText: 'يجب الموافقة على الشروط والخصوصية',
                          value: provider.agreeToTerms,
                          onChanged: provider.toggleAgreement,
                          title: Row(
                            children: [
                              Text(
                                "الشروط والخصوصية ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "موافق على",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        CustomElevatedButton(
                          text: 'متابعة',
                          onPressed: () async {
                            final provider = Provider.of<SignUpProvider>(
                                context,
                                listen: false);
                            provider.markTriedSubmit();
                            provider.validateFields();

                            if (provider.emailError != null ||
                                provider.passwordError != null ||
                                provider.confirmPasswordError != null ||
                                provider.phoneError != null ||
                                provider.checkboxError != null) {
                              return;
                            }

                            final isCompany = provider.selectedValue == 'شركة';
                            final userData = {
                              "first_name":
                                  provider.firstNameController.text.trim(),
                              "last_name":
                                  provider.lastNameController.text.trim(),
                              "birth_date":
                                  provider.birthDateController.text.trim(),
                              "email": provider.emailController.text.trim(),
                              "password":
                                  provider.passwordController.text.trim(),
                              "phone": provider.phoneController.text.trim(),
                              "role": provider.selectedValue,
                              if (isCompany) ...{
                                "company_name":
                                    provider.companyNameController.text.trim(),
                                "company_date":
                                    provider.companyDateController.text.trim(),
                                "company_address": provider
                                    .companyAddressController.text
                                    .trim(),
                                "tax_number":
                                    provider.taxNumberController.text.trim(),
                              },
                            };

                            final missingField = userData.entries.firstWhere(
                              (entry) => entry.value.toString().isEmpty,
                              orElse: () => const MapEntry('none', ''),
                            );

                            if (missingField.key != 'none') {
                              provider.customShowSnackBar(
                                context,
                                'يرجى تعبئة جميع الحقول المطلوبة',
                                Colors.redAccent,
                              );
                              return;
                            }

                            final success =
                                await provider.signUpUser(context, userData);

                            if (success) {
                              showActivateAccount(context);
                            }
                          },
                          backgroundColor: kprimaryColor,
                          textColor: grey9,
                          date: false,
                        ),
                        SizedBox(height: 16.h),
                        OrRow(),
                        SizedBox(height: 16.h),
                        Consumer<LoginProvider>(
                          builder: (context, authProvider, child) {
                            return SocialButton(
                              facebook: false,
                              onPressed: () =>
                                  authProvider.googleLogin(context),
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
                    ),
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

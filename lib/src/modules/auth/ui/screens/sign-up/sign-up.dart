// signup_screen.dart
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/checkbox.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-dropdowm.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/phone-section.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/widgets/terms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';
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
    return ChangeNotifierProvider(
      create: (_) => SignUpProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: SingleChildScrollView(
              child: Consumer<SignUpProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 48.h),
                      _buildTitle(),
                      SizedBox(height: 10.h),
                      _buildAccountTypeDropdown(provider),
                      _buildFormFields(provider, context),
                      _buildTermsCheckbox(provider, context),
                      SizedBox(height: 12.h),
                      _buildSignUpButton(context, provider),
                      SizedBox(height: 16.h),
                      OrRow(),
                      SizedBox(height: 16.h),
                      _buildSocialButtons(),
                      SizedBox(height: 16.h),
                      _buildLoginRedirect(),
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

  Widget _buildTitle() {
    return Text(
      "تسجيل جديد",
      style: TextStyle(
        fontSize: 20.sp,
        color: kprimaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAccountTypeDropdown(SignUpProvider provider) {
    return CustomDropdown(
      items: const ["شخصي", "شركة"],
      hint: "اختر نوع الحساب",
      onChanged: (value) => provider.setSelectedValue(value),
    );
  }

  Widget _buildFormFields(SignUpProvider provider, context) {
    return Column(
      children: [
        if (provider.selectedValue == "شخصي")
          _buildPersonalFields(provider, context)
        else if (provider.selectedValue == "شركة")
          _buildCompanyFields(provider, context),
        if (provider.selectedValue == 'شخصي') SizedBox(height: 18.h),
        _buildEmailField(provider),
        SizedBox(height: 18.h),
        _buildPasswordFields(provider),
        SizedBox(height: 18.h),
        _buildPhoneField(provider),
      ],
    );
  }

  Widget _buildPersonalFields(SignUpProvider provider, context) {
    return Column(
      children: [
        SizedBox(height: 18.h),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                isRequired: true,
                errorText: provider.getFieldError('lastName'),
                bgcolor: grey8,
                controller: provider.lastNameController,
                hint: "ادخل الكنية",
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: CustomTextField(
                isRequired: true,
                errorText: provider.getFieldError('firstName'),
                bgcolor: grey8,
                controller: provider.firstNameController,
                hint: "ادخل الاسم",
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        _buildDateField(
          controller: provider.birthDateController,
          hint: 'تاريخ الميلاد',
          errorKey: 'birthDate',
          context: context,
          provider: provider,
        ),
      ],
    );
  }

  Widget _buildCompanyFields(SignUpProvider provider, context) {
    return Column(
      children: [
        SizedBox(height: 18.h),
        CustomTextField(
          isRequired: true,
          errorText: provider.getFieldError('companyName'),
          bgcolor: grey8,
          controller: provider.companyNameController,
          hint: "اسم الشركة",
        ),
        SizedBox(height: 18.h),
        _buildDateField(
          context: context,
          controller: provider.companyDateController,
          hint: 'تاريخ إنشاء الشركة',
          errorKey: 'companyDate',
          provider: provider,
        ),
        SizedBox(height: 18.h),
      ],
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String hint,
    required String errorKey,
    required BuildContext context,
    required SignUpProvider provider,
  }) {
    return CustomTextField(
      isRequired: true,
      errorText: provider.getFieldError(errorKey),
      prefix: GestureDetector(
        onTap: () => showDatePickerDialog(context, controller),
        child: SvgPicture.asset(
          calendarIcon,
          height: 20.h,
          width: 20.w,
        ),
      ),
      controller: controller,
      bgcolor: grey8,
      hint: hint,
    );
  }

  Widget _buildEmailField(SignUpProvider provider) {
    return CustomTextField(
      isRequired: true,
      errorText: provider.emailError,
      bgcolor: grey8,
      controller: provider.emailController,
      hint: "البريد الإلكتروني",
    );
  }

  Widget _buildPasswordFields(SignUpProvider provider) {
    return Column(
      children: [
        CustomPasswordField(
          isConfirmField: false,
          controller: provider.passwordController,
          hint: "كلمة المرور",
          errorText: provider.passwordError,
          onChanged: provider.validatePasswordOnChange,
        ),
        SizedBox(height: 18.h),
        CustomPasswordField(
          isConfirmField: true,
          controller: provider.confirmPasswordController,
          hint: "تأكيد كلمة المرور",
          errorText: provider.confirmPasswordError,
          onChanged: provider.validateConfirmPasswordOnChange,
        ),
      ],
    );
  }

  Widget _buildPhoneField(SignUpProvider provider) {
    return PhoneSection(
      controller: provider.phoneController,
      errorText: provider.phoneError,
    );
  }

  Widget _buildTermsCheckbox(SignUpProvider provider, context) {
    return CustomCheckBox(
      errorText: provider.checkboxErrorText,
      value: provider.agreeToTerms,
      onChanged: provider.toggleAgreement,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
            ),
            onPressed: () =>
                Navigator.pushNamed(context, ConditionsAndTermsScreen.id),
            child: Text(
              "الشروط والأحكام ",
              style: GoogleFonts.tajawal(
                textStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.blue,
                ),
              ),
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
    );
  }

  Widget _buildSignUpButton(BuildContext context, SignUpProvider provider) {
    return CustomElevatedButton(
      text: provider.isLoading ? 'جاري التسجيل' : 'متابعة',
      onPressed: () => _handleSignUp(context, provider),
      backgroundColor: provider.isLoading ? kprimary3Color : kprimaryColor,
      textColor: grey9,
      date: false,
    );
  }

  Widget _buildSocialButtons() {
    return Column(
      children: [
        Consumer<LoginProvider>(
          builder: (context, authProvider, child) {
            return SocialButton(
              facebook: false,
              onPressed: () => _handleGoogleSignIn(authProvider),
              text: "الاستمرار بجوجل Google",
              image: googlePath,
            );
          },
        ),
        SizedBox(height: 8.h),
        SocialButton(
          facebook: true,
          onPressed: () {}, // Facebook login implementation
          text: "الاستمرار بالفيسبوك Facebook",
          image: facebookPath,
        ),
      ],
    );
  }

  Widget _buildLoginRedirect() {
    return const InsteadWidget(
      question: 'هل لديك حساب؟',
      action: 'سجل دخول',
      route: LoginScreen.id,
    );
  }

  Future<void> _handleSignUp(
      BuildContext context, SignUpProvider provider) async {
    provider.markTriedSubmit();

    if (!provider.validateAllFields()) {
      return;
    }

    final userData = provider.buildUserData();

    if (!provider.validateRequiredFields(userData)) {
      provider.showErrorMessage(context, 'يرجى تعبئة جميع الحقول المطلوبة');
      return;
    }

    final success = await provider.signUpUser(context, userData);

    if (success) {
      await showActivateAccount(context);
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
  }

  Future<void> _handleGoogleSignIn(LoginProvider authProvider) async {
    try {
      print("Google login button pressed.");

      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        print('User canceled the sign-in');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      print('Access token: ${googleAuth.accessToken}');
      print('ID token: ${googleAuth.idToken}');

      if (idToken == null) {
        print('Failed to get ID Token.');
        return;
      }

      print('User signed in successfully with Google: ${googleUser.email}');
      await authProvider.googleLogin(idToken);
    } catch (e) {
      print('Error during Google Sign-In: $e');
    }
  }
}

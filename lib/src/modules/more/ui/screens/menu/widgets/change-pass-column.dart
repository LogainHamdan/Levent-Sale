import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/repos/token-helper.dart';
import '../../../../../auth/ui/alerts/alert.dart';
import '../../../../../auth/ui/screens/login/widgets/confrm-cancel-button.dart';
import '../../../../../auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import '../../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../provider.dart';

class ChangePassColumn extends StatelessWidget {
  static const id = '/change-pass';
  final int? userId;
  final bool alert;

  const ChangePassColumn({
    super.key,
    this.userId,
    required this.alert,
  });

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (alert)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: SvgPicture.asset(
                        cancelPath,
                        height: 18.h,
                        width: 18.w,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    SizedBox(height: 20.h),
                    TitleRow(title: 'تغير كلمة المرور'),
                  ],
                ),
              if (alert) ...[
                SizedBox(height: 16.h),
                Text('تعيين كلمة المرور',
                    style: GoogleFonts.tajawal(
                        color: kprimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp)),
                SizedBox(height: 5.h),
                Text(
                  textAlign: TextAlign.center,
                  'قم بإدخال كلمة المرور الجديدة ومن ثم تأكيدها مرة أخرى',
                  style: GoogleFonts.tajawal(color: grey3, fontSize: 12.sp),
                ),
              ],
              SizedBox(height: 16.h),
              alert
                  ? CustomTextField(
                      bgcolor: grey8,
                      controller: menuProvider.sentCodeController,
                      hint: 'أدخل الرمز المرسل')
                  : CustomPasswordField(
                      controller: menuProvider.oldPassController,
                      hint: 'كلمة المرور الحالية'),
              SizedBox(height: 12.h),
              CustomPasswordField(
                controller: alert
                    ? menuProvider.newPassAlertController
                    : menuProvider.newPassController,
                hint: 'كلمة المرور الجديدة',
              ),
              //  SizedBox(height: 12.h),
              // CustomPasswordField(
              //   controller: alert
              //       ? menuProvider.confirmNewPassAlertController
              //       : menuProvider.confirmNewPassController,
              //   hint: 'تأكيد كلمة المرور الجديدة',
              // ),
              SizedBox(height: 24.h),
              CustomElevatedButton(
                text: 'تغيير كلمة المرور',
                onPressed: () async {
                  final token = await TokenHelper.getToken();

                  if (token == null || token.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('حدث خطأ: لم يتم العثور على التوكن')),
                    );
                    return;
                  }

                  if (alert) {
                    await menuProvider.changePasswordWithToken(token: token);
                  } else {
                    await menuProvider.submitChangePassword(
                      context: context,
                      userId: userId ?? 0,
                      token: token,
                    );
                  }

                  Navigator.pop(context);
                  showPasswordUpdated(context);
                },
                backgroundColor: kprimaryColor,
                textColor: grey9,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

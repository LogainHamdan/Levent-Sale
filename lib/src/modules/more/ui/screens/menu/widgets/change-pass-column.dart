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
  TextEditingController? oldPassController;
  TextEditingController? sentCodeController;
  TextEditingController? newPassAlertController;
  TextEditingController? confirmNewPassAlertController;
  TextEditingController? newPassController;
  TextEditingController? confirmNewPassController;
  int? userId;

  final bool alert;

  ChangePassColumn(
      {super.key,
      this.sentCodeController,
      this.oldPassController,
      this.newPassAlertController,
      this.confirmNewPassAlertController,
      this.newPassController,
      this.confirmNewPassController,
      this.userId = 0,
      required this.alert});

  @override
  Widget build(BuildContext context) {
    sentCodeController = TextEditingController(text: '');
    oldPassController = TextEditingController(text: '');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        alert
            ? Row(
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
            : Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  TitleRow(
                    title: 'تغيير كلمة المرور',
                  ),
                ],
              ),
        alert
            ? SizedBox(
                height: 16.h,
              )
            : SizedBox(),
        alert
            ? Text(
                'تعيين كلمة المرور',
                style: GoogleFonts.tajawal(
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              )
            : SizedBox(),
        alert ? SizedBox(height: 5.h) : SizedBox(),
        alert
            ? Text(
                textAlign: TextAlign.center,
                'قم بإدخال كلمة المرور الجديدة ومن ثم تأكيدها مرة أخرى',
                style: GoogleFonts.tajawal(color: grey3, fontSize: 12.sp),
              )
            : SizedBox(),
        SizedBox(
          height: 16.h,
        ),
        alert
            ? CustomTextField(
                bgcolor: grey8,
                controller: sentCodeController!,
                hint: 'أدخل الرمز المرسل')
            : CustomPasswordField(
                controller: oldPassController!, hint: 'كلمة المرور الحالية'),
        SizedBox(
          height: 12.h,
        ),
        CustomPasswordField(
            controller: alert ? newPassAlertController! : newPassController!,
            hint: 'كلمة المرور الجديدة'),
        SizedBox(
          height: 12.h,
        ),
        CustomPasswordField(
            controller: alert
                ? confirmNewPassAlertController!
                : confirmNewPassController!,
            hint: 'تأكيد كلمة المرور الجديدة'),
        SizedBox(
          height: 24.h,
        ),
        CustomElevatedButton(
          text: 'تغيير كلمة المرور',
          onPressed: () async {
            final token = await TokenHelper.getToken();

            final menuProvider =
                Provider.of<MenuProvider>(context, listen: false);
            if (token == null || token.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('حدث خطأ: لم يتم العثور على التوكن')),
              );
              return;
            }
            alert
                ? menuProvider.changePasswordWithToken(
                    newPass: newPassAlertController!.text.trim(),
                    confirmPass: confirmNewPassAlertController!.text.trim(),
                    token: token,
                  )
                : menuProvider.submitChangePassword(
                    context: context,
                    userId: userId!,
                    oldPass: oldPassController!.text.trim(),
                    newPass: newPassController!.text.trim(),
                    confirmPass: confirmNewPassController!.text.trim(),
                    token: token,
                  );
            Navigator.pop(context);
            showPasswordUpdated(context);
          },
          backgroundColor: kprimaryColor,
          textColor: grey9,
        ),
      ],
    );
  }
}

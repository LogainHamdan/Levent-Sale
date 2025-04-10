import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/alerts/alert.dart';
import '../../../../../auth/ui/screens/login/widgets/confrm-cancel-button.dart';
import '../../../../../auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import '../../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../provider.dart';

class ChangePassColumn extends StatelessWidget {
  TextEditingController? currentPassController;
  TextEditingController? sentCodeController;
  int? userId;

  TextEditingController? secondController;
  TextEditingController? thirdController;
  final bool alert;

  ChangePassColumn(
      {super.key,
      this.secondController,
      this.sentCodeController,
      this.currentPassController,
      this.thirdController,
      this.userId = 0,
      required this.alert});

  @override
  Widget build(BuildContext context) {
    secondController = TextEditingController(text: '');
    sentCodeController = TextEditingController(text: '');
    currentPassController = TextEditingController(text: '');
    thirdController = TextEditingController(text: '');
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
                controller: currentPassController!,
                hint: 'كلمة المرور الحالية'),
        SizedBox(
          height: 12.h,
        ),
        CustomPasswordField(
            controller: secondController!, hint: 'كلمة المرور الجديدة'),
        SizedBox(
          height: 12.h,
        ),
        CustomPasswordField(
            controller: thirdController!, hint: 'تأكيد كلمة المرور الجديدة'),
        SizedBox(
          height: 24.h,
        ),
        CustomElevatedButton(
          text: 'تغيير كلمة المرور',
          onPressed: () {
            final menuProvider =
                Provider.of<MenuProvider>(context, listen: false);
            menuProvider.submitChangePassword(
              context: context,
              userId: userId!,
              oldPass: currentPassController!.text.trim(),
              newPass: secondController!.text.trim(),
              confirmPass: thirdController!.text.trim(),
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

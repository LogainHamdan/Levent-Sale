import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../auth/ui/screens/login/widgets/confrm-cancel-button.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';

class ChangePassColumn extends StatelessWidget {
  TextEditingController? firstController;
  TextEditingController? secondController;
  TextEditingController? thirdController;
  final bool alert;

  ChangePassColumn(
      {super.key,
      this.firstController,
      this.secondController,
      this.thirdController,
      required this.alert});

  @override
  Widget build(BuildContext context) {
    firstController = TextEditingController(text: '');
    secondController = TextEditingController(text: '');
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
                      height: 20.h,
                    ),
                  ),
                ],
              )
            : TitleRow(
                title: 'تغيير كلمة المرور',
              ),
        alert
            ? SizedBox(
                height: 20.h,
              )
            : SizedBox(),
        Padding(
          padding: EdgeInsets.only(top: 16.0.h),
          child: Text(
            'تعيين كلمة المرور',
            style: GoogleFonts.tajawal(
                color: kprimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          textAlign: TextAlign.center,
          'قم بإدخال كلمة المرور الجديدة ومن ثم تأكيدها مرة أخرى',
          style: GoogleFonts.tajawal(color: grey3, fontSize: 12.sp),
        ),
        SizedBox(
          height: 16.h,
        ),
        alert
            ? CustomTextField(
                bgcolor: grey8,
                controller: firstController!,
                hint: 'أدخل الرمز المرسل')
            : CustomPasswordField(
                controller: firstController!, hint: 'كلمة المرور الحالية'),
        SizedBox(
          height: 16.h,
        ),
        CustomPasswordField(
            controller: secondController!, hint: 'كلمة المرور الجديدة'),
        SizedBox(
          height: 16.h,
        ),
        CustomPasswordField(
            controller: thirdController!, hint: 'تأكيد كلمة المرور الجديدة'),
        SizedBox(
          height: 16.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: CustomElevatedButton(
              text: 'تغيير كلمة المرور',
              onPressed: () => showPasswordUpdated(context),
              backgroundColor: kprimaryColor,
              textColor: grey9),
        )
      ],
    );
  }
}

import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../auth/ui/screens/login/widgets/confrm-cancel-button.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';

class ChangePassColumn extends StatelessWidget {
  static const id = '/change-pass';

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
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          alert
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset(
                        'assets/imgs_icons/auth/assets/icons/cancel.png',
                        height: 20.h,
                      ),
                    ),
                  ],
                )
              : TitleRow(
                  onBackTap: () =>
                      Navigator.pushReplacementNamed(context, MenuScreen.id),
                  title: 'تغيير كلمة المرور'),
          Padding(
            padding: EdgeInsets.only(top: 8.0.h),
            child: Text(
              'تعيين كلمة المرور',
              style: GoogleFonts.tajawal(
                  color: kprimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            textAlign: TextAlign.center,
            'قم بإدخال كلمة المرور الجديدة ومن ثم تأكيدها مرة أخرى',
            style: GoogleFonts.tajawal(color: grey4, fontSize: 15.sp),
          ),
          alert
              ? CustomTextField(
                  bgcolor: grey8,
                  controller: firstController!,
                  hint: 'أدخل الرمز المرسل')
              : CustomPasswordField(
                  controller: firstController!, hint: 'كلمة المرور الحالية'),
          SizedBox(
            height: 8.h,
          ),
          CustomPasswordField(
              controller: secondController!, hint: 'كلمة المرور الجديدة'),
          SizedBox(
            height: 8.h,
          ),
          CustomPasswordField(
              controller: thirdController!, hint: 'تأكيد كلمة المرور الجديدة'),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(height: 25.h),
          alert
              ? ConfirmCancelButton(
                  text: 'تأكيد',
                  onPressed: () => showPasswordUpdated(context),
                  backgroundColor: kprimaryColor,
                  textColor: Colors.white,
                )
              : Padding(
                  padding: EdgeInsets.all(14.0.sp),
                  child: CustomElevatedButton(
                      text: 'تغيير كلمة المرور',
                      onPressed: () => showPasswordUpdated(context),
                      backgroundColor: kprimaryColor,
                      textColor: Colors.white),
                ),
        ],
      ),
    );
  }
}

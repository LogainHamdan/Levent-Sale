import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/simple-title.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/delete-account/why-to-delete.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccountScreen extends StatelessWidget {
  static const id = '/delete';
  final bool phase1email;
  final String? emailAddress;

  const DeleteAccountScreen({
    super.key,
    required this.phase1email,
    this.emailAddress = 'logain.s.m.hamdan@gmail.com',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            titleTextStyle: Theme.of(context).textTheme.bodyLarge,
            title: TitleRow(
                onBackTap: () =>
                    Navigator.pushReplacementNamed(context, MenuScreen.id),
                title: 'حذف الحساب'),
            leading: SizedBox()),
        body: phase1email
            ? Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.sp),
                    Text(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      'لحذف الحساب ادخل بريدك الاكتروني المربوط بالحساب',
                      style: TextStyle(color: kprimaryColor, fontSize: 18.sp),
                    ),
                    SizedBox(height: 10.sp),
                    CustomTextField(
                      label: 'البريد الإلكتروني',
                      controller: TextEditingController(),
                      bgcolor: grey7,
                      hint: 'logain.s.m.hamdan@gmail.com',
                    ),
                    SizedBox(height: 30.sp),
                    CustomElevatedButton(
                        text: 'تحقق',
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DeleteAccountScreen(phase1email: false))),
                        backgroundColor: kprimaryColor,
                        textColor: Colors.white),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 10.sp),
                    Text(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      'ادخل رمز التحقق',
                      style: TextStyle(
                          color: kprimaryColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      'المرسل على الإيميل $emailAddress',
                      style: TextStyle(color: grey4, fontSize: 14.sp),
                    ),
                    SizedBox(height: 30.sp),
                    CustomTextField(
                      label: 'رمز التحقق',
                      controller: TextEditingController(),
                      bgcolor: grey7,
                      hint: '7AWW56',
                    ),
                    SizedBox(height: 30.sp),
                    CustomElevatedButton(
                        text: 'حذف الحساب',
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, WhyToDeleteScreen.id),
                        backgroundColor: kprimaryColor,
                        textColor: Colors.white),
                  ],
                ),
              ),
      ),
    );
  }
}

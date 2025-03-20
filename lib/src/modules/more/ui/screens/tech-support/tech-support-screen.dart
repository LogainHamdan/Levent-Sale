import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Column(
        children: [
          CustomTextField(
              suffix: Icon(
                Icons.email_outlined,
                color: grey5,
              ),
              label: 'البريد الإلكتروني',
              controller: TextEditingController(),
              hint: 'logain.s.m.hamdan@gmail.com',
              bgcolor: grey8),
          CustomTextField(
            controller: TextEditingController(),
            label: 'الرسالة',
            bgcolor: grey8,
            paragraph: true,
            paragraphBorderRadius: 2,
          ),
          SizedBox(height: 10.h),
          CustomElevatedButton(
            text: 'ارسال',
            onPressed: () {},
            backgroundColor: kprimaryColor,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}

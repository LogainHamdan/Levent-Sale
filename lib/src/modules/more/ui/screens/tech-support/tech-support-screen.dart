import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../main/ui/screens/main_screen.dart';
import '../../../../main/ui/screens/provider.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

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
              hint: 'menna@gmail.com',
              bgcolor: grey8),
          SizedBox(height: 16.h),
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
            onPressed: () {
              bottomNavProvider.setIndex(0);
              Navigator.pushNamed(context, MainScreen.id);
            },
            backgroundColor: kprimaryColor,
            textColor: grey9,
          )
        ],
      ),
    );
  }
}

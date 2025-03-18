import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';

class EmptyCollection extends StatelessWidget {
  const EmptyCollection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        Image.asset(
          'assets/imgs_icons/sections/assets/icons/اعلاناتي فارغة.png',
          height: 120.h,
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          'إعلاناتي فارغة',
          style: TextStyle(
            color: grey3,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
          child: CustomElevatedButton(
              text: 'ابدأ في انشاء إعلانك',
              onPressed: () {},
              backgroundColor: kprimaryColor,
              textColor: Colors.white,
              date: false,
              notText: true),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}

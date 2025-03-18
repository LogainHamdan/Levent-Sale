import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';
import '../../../../../home/ui/screens/evaluation/widgets/img-picker.dart';

class ImagePickerColumn extends StatelessWidget {
  const ImagePickerColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      decoration:
          BoxDecoration(color: grey8, borderRadius: BorderRadius.circular(5.r)),
      child: Padding(
        padding: EdgeInsets.only(top: 35.0.h),
        child: Center(
          child: ImagePickerWidget(
            icon: Image.asset(
                height: 60.h,
                'assets/imgs_icons/sections/assets/icons/اضافة صورة.png'),
          ),
        ),
      ),
    );
  }
}

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add-photo-container.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
                child: Image.asset(
                  'assets/imgs_icons/home/assets/imgs/منال.png',
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Image.asset(
              'assets/imgs_icons/more/assets/icons/camera.png',
              height: 25.h,
            )
          ],
        ),
        SizedBox(height: 20.h),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            textDirection: TextDirection.rtl,
            'صورة غلاف الملف الشخصي',
            style: TextStyle(
              color: grey5,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        UploadPhotoContainer(),
      ],
    );
  }
}

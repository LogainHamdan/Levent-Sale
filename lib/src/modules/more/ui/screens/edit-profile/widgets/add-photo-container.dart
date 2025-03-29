import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../provider.dart';

class UploadPhotoContainer extends StatelessWidget {
  const UploadPhotoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context);
    final File? coverImage = editProfileProvider.coverImage;

    return GestureDetector(
      onTap: () => editProfileProvider.pickCoverImage(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        height: 150.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kprimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(3.r),
        ),
        child: coverImage == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_downward,
                    color: kprimaryColor,
                    size: 30.sp,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'أضف صورة غلاف الملف الشخصي',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: kprimaryColor),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(3.r),
                child: Image.file(
                  coverImage,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 150.h,
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../provider.dart';

class UploadPhotoContainer extends StatelessWidget {
  const UploadPhotoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<EditProfileProvider>(context);

    return GestureDetector(
      onTap: () => imageProvider.pickImage(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        height: 150.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: grey8,
          borderRadius: BorderRadius.circular(3.r),
        ),
        child: imageProvider.image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'أضف صورة غلاف الملف الشخصي',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: kprimaryColor),
                  ),
                  SizedBox(height: 10.h),
                  Icon(
                    Icons.arrow_downward,
                    color: kprimaryColor,
                    size: 30,
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(3.r),
                child: Image.file(
                  imageProvider.image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
      ),
    );
  }
}

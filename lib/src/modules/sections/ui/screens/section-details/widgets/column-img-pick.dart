import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';

class ImagePickerColumn extends StatelessWidget {
  const ImagePickerColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<SectionDetailsProvider>(context, listen: false);

    return GestureDetector(
      onTap: provider.pickImage,
      child: Container(
        height: 140.h,
        decoration: BoxDecoration(
          color: grey8,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Center(
          child: Image.asset(
            height: 78.h,
            width: 78.w,
            addImageIcon,
          ),
        ),
      ),
    );
  }
}

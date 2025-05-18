import 'dart:io';
import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/create-ad-section-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details1.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/update-ad-section-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SelectedImagesSectionUpdate extends StatelessWidget {
  const SelectedImagesSectionUpdate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateAdSectionDetailsProvider>(
      builder: (context, provider, child) {
        if (provider.selectedImages.isEmpty) {
          return SizedBox();
        }

        return Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: List.generate(provider.selectedImages.length, (index) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(
                    provider.selectedImages[index],
                    width: 70.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 1,
                  child: GestureDetector(
                    onTap: () => provider.removeImage(index),
                    child: SvgPicture.asset(
                      cancelPath,
                      height: 15.h,
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}

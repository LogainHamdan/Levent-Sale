import 'dart:io';
import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/create-ad-section-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../update-ad-section-details.dart';

class SelectedImagesSection extends StatelessWidget {
  final bool create;
  const SelectedImagesSection({super.key, required this.create});

  @override
  Widget build(BuildContext context) {
    return create
        ? Consumer<CreateAdSectionDetailsProvider>(
            builder: (context, createProvider, child) {
              if (createProvider.selectedImages.isEmpty) {
                return SizedBox();
              }

              return Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: List.generate(createProvider.selectedImages.length,
                    (index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.file(
                          createProvider.selectedImages[index],
                          width: 70.w,
                          height: 50.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 1,
                        child: GestureDetector(
                          onTap: () => createProvider.removeImage(index),
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
          )
        : Consumer<UpdateAdSectionDetailsProvider>(
            builder: (context, updateProvider, child) {
              if (updateProvider.selectedImages.isEmpty) {
                return SizedBox();
              }

              return Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: List.generate(updateProvider.selectedImages.length,
                    (index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.file(
                          updateProvider.selectedImages[index],
                          width: 70.w,
                          height: 50.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 1,
                        child: GestureDetector(
                          onTap: () => updateProvider.removeImage(index),
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

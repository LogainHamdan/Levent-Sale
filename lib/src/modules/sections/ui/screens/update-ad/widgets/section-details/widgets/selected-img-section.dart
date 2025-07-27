import 'dart:io';
import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details1.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../provider.dart';

class SelectedImagesSectionUpdate extends StatelessWidget {
  const SelectedImagesSectionUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    final updateProvider =
        Provider.of<UpdateAdProvider>(context, listen: false);

    return Consumer<UpdateAdSectionDetailsProvider>(
      builder: (context, provider, child) {
        final List<File> fileImages = provider.selectedImages;

        if (fileImages.isEmpty) {
          return const SizedBox();
        }

        return Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: List.generate(fileImages.length, (index) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(
                    fileImages[index],
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

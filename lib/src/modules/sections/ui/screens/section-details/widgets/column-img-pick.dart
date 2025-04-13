import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/create-ad-section-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../update-ad-section-details.dart';

class ImagePickerColumn extends StatelessWidget {
  final bool create;
  const ImagePickerColumn({super.key, required this.create});

  @override
  Widget build(BuildContext context) {
    final createProvider =
        Provider.of<CreateAdSectionDetailsProvider>(context, listen: false);
    final updateProvider =
        Provider.of<UpdateAdSectionDetailsProvider>(context, listen: false);

    return GestureDetector(
      onTap: create ? createProvider.pickImage : updateProvider.pickImage,
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

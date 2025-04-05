import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../config/constants.dart';
import '../../../../../sections/ui/screens/one-section/one-section.dart';

class SectionItem extends StatelessWidget {
  final String category;
  final String img;

  const SectionItem({
    super.key,
    required this.category,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Section.id),
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 30.r,
              backgroundColor: grey7,
              child: Padding(
                padding: EdgeInsets.all(6.r),
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 9.h),
          Text(
            category,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
                color: kprimaryColor),
          ),
        ],
      ),
    );
  }
}

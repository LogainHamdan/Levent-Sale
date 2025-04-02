import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/search-field.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/sections/sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../home/ui/screens/ads/widgets/products-details.dart';
import '../../../../home/ui/screens/home/data.dart';

class Section extends StatelessWidget {
  static const id = '/section';

  const Section({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController sectionController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30.h),
          TitleRow(
              onBackTap: () => Navigator.pushNamed(context, Sections.id),
              title: 'الاجهزة'),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0.w,
            ),
            child: SearchField(
              controller: sectionController,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            child: SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: categories.map((category) {
                  return Row(
                    children: [
                      SizedBox(width: 10.w),
                      Text(
                        '(${category['count']})',
                        style: TextStyle(
                            fontSize: 14.sp, color: Colors.grey.shade600),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        category['name']!,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: Center(
                          child: SvgPicture.asset(category['image']!,
                              width: 40.w, height: 40.h),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(child: ProductsDetails()),
        ],
      ),
    );
  }
}

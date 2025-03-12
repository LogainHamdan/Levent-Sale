import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class CategoriesList extends StatelessWidget {
  final List<String> categoryNames;
  final List<String> categoryImages;

  const CategoriesList({
    super.key,
    required this.categoryNames,
    required this.categoryImages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مشاهدة المزيد',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: kprimaryColor,
                ),
              ),
              Text(
                'الأقسام',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(categoryNames.length, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0.w),
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 30.r,
                        backgroundColor: grey7,
                        child: Padding(
                          padding: EdgeInsets.all(
                              6.r), // Adjust padding to make the image smaller
                          child: Image.asset(
                            categoryImages[index],
                            fit: BoxFit
                                .contain, // Ensures the image fits within the padding
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8), // Spacing between image & text
                    Text(categoryNames[index]),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

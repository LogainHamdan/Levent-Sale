import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/section-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/one-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';
import '../../../../../main/ui/screens/main_screen.dart';
import '../../../../../sections/ui/screens/section-details/section-details.dart';
import '../../../../../sections/ui/screens/sections/sections.dart';

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
              TextButton(
                  onPressed: () => Navigator.pushNamed(context, Sections.id),
                  child: Text('مشاهدة المزيد',
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.tajawal(
                        textStyle: TextStyle(
                          fontSize: 14.sp,
                          color: kprimaryColor,
                        ),
                      ))),
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
              return SectionItem(
                  category: categoryNames[index], img: categoryImages[index]);
            }),
          ),
        ),
      ],
    );
  }
}

import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-header.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/section-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/one-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';
import '../../../../../main/ui/screens/main_screen.dart';
import '../../../../../sections/ui/screens/section-details/section-details1.dart';
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
        CustomHeader(
            title: 'الأقسام',
            onPressed: () => Navigator.pushNamed(context, Sections.id)),
        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(categoryNames.length, (index) {
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : 16.w),
                child: SectionItem(
                  category: categoryNames[index],
                  img: categoryImages[index],
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}

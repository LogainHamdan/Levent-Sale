import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-header.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/section-details.dart';
import 'package:Levant_Sale/src/modules/sections/models/root-category.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/one-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../main/ui/screens/main_screen.dart';
import '../../../../../main/ui/screens/provider.dart';
import '../../../../../sections/ui/screens/section-details/section-details1.dart';
import '../../../../../sections/ui/screens/sections/sections.dart';

class CategoriesList extends StatelessWidget {
  final List<Category> categories;

  const CategoriesList({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeader(
          title: 'الأقسام',
          onPressed: () {
            bottomNavProvider.setIndex(2);
            Navigator.pushNamed(context, MainScreen.id);
          },
        ),
        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(categories.length, (index) {
              final category = categories[index];
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : 16.w),
                child: SectionItem(
                  category: category,
                  img: category.imageUrl ?? '',
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

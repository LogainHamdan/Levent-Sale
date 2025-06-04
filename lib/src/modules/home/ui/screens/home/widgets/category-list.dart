import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-header.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/section-item.dart';
import 'package:Levant_Sale/src/modules/sections/models/root-category.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/one-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../main/ui/screens/main_screen.dart';
import '../../../../../main/ui/screens/provider.dart';
import '../../../../../sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import '../../../../../sections/ui/screens/section-details/section-details1.dart';
import '../../../../../sections/ui/screens/sections/sections.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);
    final createProvider =
        Provider.of<CreateAdChooseSectionProvider>(context, listen: false);
    final categories = createProvider.rootCategories;

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
        createProvider.isLoading
            ? CustomCircularProgressIndicator()
            : SingleChildScrollView(
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

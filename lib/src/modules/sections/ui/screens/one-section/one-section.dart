import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/search-field.dart';
import 'package:Levant_Sale/src/modules/sections/models/root-category.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/widgets/horizontal-categories.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/sections/sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/ads/widgets/products-details.dart';
import '../../../../home/ui/screens/home/data.dart';
import '../choose-section/create-ad-choose-section-provider.dart';

class Section extends StatelessWidget {
  static const id = '/section';

  const Section({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController sectionController = TextEditingController();
    final sectionsProvider =
        Provider.of<CreateAdChooseSectionProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: SizedBox(),
        title: TitleRow(
          title: homeProvider.selectedCategory!.name,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0.w,
              ),
              child: SearchField(
                width: 472.w,
                controller: sectionController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: HorizontalCategories(),
            ),
            ProductsDetails(
              productList: homeProvider.allAds,
            ),
          ],
        ),
      ),
    );
  }
}

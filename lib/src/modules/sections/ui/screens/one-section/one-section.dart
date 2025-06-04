import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/widgets/horizontal-categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/ads/widgets/products-details.dart';
import '../../../models/filter.dart';

class Section extends StatelessWidget {
  static const id = '/section';

  const Section({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SectionProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: SizedBox(),
        title: TitleRow(
          title: homeProvider.selectedCategory?.name ?? "",
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: provider.fetchCategoryAds(
              categoryId: '${homeProvider.selectedCategory?.id}',
              FilterRequestDTO(filters: {}, searchAttributes: [])),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomCircularProgressIndicator();
            }

            return Consumer<SectionProvider>(
              builder: (context, sectionProvider, child) {
                if (sectionProvider.isLoading || homeProvider.isLoading) {
                  return CustomCircularProgressIndicator();
                }
                return Column(
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 16.0.w,
                    //   ),
                    //   child: SearchField(
                    //     width: 472.w,
                    //     controller: sectionController,
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      child: HorizontalCategories(),
                    ),
                    ProductsDetails(
                      productList: sectionProvider.adsByCategory,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

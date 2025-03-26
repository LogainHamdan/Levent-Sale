import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/products-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/product-section.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/search-field.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search/widgets/result-widget.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/empty-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../home/data.dart';

class SearchScreen extends StatelessWidget {
  static const id = '/search';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<SearchProvider>(); // استخدام watch للحصول على التحديثات

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                SearchField(
                  controller: provider.searchController,
                  // onChanged: (text) {
                  //   provider
                  //       .searchQueryUpdated(); // تحديث النتائج عند تغيير النص
                  // },
                ),
                SizedBox(height: 20.h),
                // عرض نتائج البحث بعد التحديث
                SearchResultsWidget(
                  provider: provider,
                ),
                SizedBox(height: 40.h),
                ProductSection(
                  isHalfed: true,
                  onMorePressed: () =>
                      Navigator.pushReplacementNamed(context, AdsScreen.id),
                  category: "العروض والخصومات",
                  products: products,
                ),
                ProductSection(
                  isHalfed: true,
                  onMorePressed: () =>
                      Navigator.pushReplacementNamed(context, AdsScreen.id),
                  category: "الإعلانات الجديدة",
                  products: products,
                ),
                ProductSection(
                  isHalfed: true,
                  onMorePressed: () =>
                      Navigator.pushReplacementNamed(context, AdsScreen.id),
                  category: "الإعلانات المفترحة",
                  products: products,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

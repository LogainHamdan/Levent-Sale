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
import '../chats/no-info-widget.dart';
import '../home/data.dart';
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
    final provider = context.watch<SearchProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Row(
                  children: [
                    SearchField(
                      width: 295,
                      controller: provider.searchController,
                      onChanged: (value) {
                        provider.searchQueryUpdated();
                      },
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    InkWell(
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          size: 24.sp,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
                SizedBox(height: 24.h),
                provider.searchController.text.isEmpty ||
                        provider.searchResults.isEmpty
                    ? NoInfoWidget(
                        msg: 'لا يوجد نتائج بحث مطابقة',
                        img: searchNoResultIcon,
                      )
                    : SearchResultsWidget(
                        provider: provider,
                      ),
                SizedBox(height: 100.h),
                ProductSection(
                  isHalfed: true,
                  onMorePressed: () =>
                      Navigator.pushNamed(context, AdsScreen.id),
                  category: "العروض والخصومات",
                  products: products,
                ),
                ProductSection(
                  isHalfed: true,
                  onMorePressed: () =>
                      Navigator.pushNamed(context, AdsScreen.id),
                  category: "الإعلانات الجديدة",
                  products: products,
                ),
                ProductSection(
                  isHalfed: true,
                  onMorePressed: () =>
                      Navigator.pushNamed(context, AdsScreen.id),
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

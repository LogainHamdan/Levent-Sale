import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/banner.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/category-list.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/product-section.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/top-search.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'data.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 12.0.h, right: 10.w, left: 10.w),
            child: Column(
              children: [
                TopSearchBar(),
                TopBanner(),
                CategoriesList(
                    categoryNames: categoryNames,
                    categoryImages: categoryImages),
                SizedBox(
                  height: 10.h,
                ),
                ProductSection(
                    width: 120.w,
                    height: 130.h,
                    onMorePressed: () =>
                        Navigator.pushNamed(context, AdsScreen.id),
                    category: "العروض والخصومات",
                    products: products),
                ProductSection(
                    height: 130.h,
                    width: 120.w,
                    onMorePressed: () =>
                        Navigator.pushNamed(context, AdsScreen.id),
                    category: "الإعلانات الجديدة",
                    products: products),
                ProductSection(
                    height: 130.h,
                    width: 120.w,
                    onMorePressed: () =>
                        Navigator.pushNamed(context, AdsScreen.id),
                    category: "الإعلانات المقترحة",
                    products: products),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

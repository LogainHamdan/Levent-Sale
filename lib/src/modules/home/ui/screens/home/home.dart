import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/banner.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/category-list.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/product-section.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/top-search.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../nav-bar/custom_nav_bar.dart';
import 'data.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopSearchBar(),
              TopBanner(),
              CategoriesList(
                  categoryNames: categoryNames, categoryImages: categoryImages),
              SizedBox(
                height: 22.h,
              ),
              ProductSection(
                  onMorePressed: () =>
                      Navigator.pushReplacementNamed(context, AdsScreen.id),
                  category: "العروض والخصومات",
                  products: products),
              ProductSection(
                  onMorePressed: () =>
                      Navigator.pushReplacementNamed(context, AdsScreen.id),
                  category: "الإعلانات الجديدة",
                  products: products),
              ProductSection(
                  onMorePressed: () =>
                      Navigator.pushReplacementNamed(context, AdsScreen.id),
                  category: "الإعلانات المفترحة",
                  products: products),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),

      // bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

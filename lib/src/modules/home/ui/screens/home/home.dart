import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tajawal/src/config/constants.dart';
import 'package:tajawal/src/modules/home/ui/screens/home/widgets/banner.dart';
import 'package:tajawal/src/modules/home/ui/screens/home/widgets/category-list.dart';
import 'package:tajawal/src/modules/home/ui/screens/home/widgets/favorite-bitton.dart';
import 'package:tajawal/src/modules/home/ui/screens/home/widgets/product-section.dart';
import 'package:tajawal/src/modules/home/ui/screens/home/widgets/top-search.dart';
import '../../../../nav-bar/custom_nav_bar.dart';
import 'data.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/home';

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
              ProductSection(category: "العروض والخصومات", products: products),
              ProductSection(category: "الإعلانات الجديدة", products: products),
              ProductSection(
                  category: "الإعلانات المفترحة", products: products),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

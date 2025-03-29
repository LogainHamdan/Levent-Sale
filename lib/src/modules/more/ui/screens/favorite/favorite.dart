import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/widgets/empty-fav.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/widgets/fav-grid.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';

import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/empty-widget.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/join-collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../home/ui/screens/ads/ads.dart';
import '../../../../home/ui/screens/ads/widgets/products-details.dart';
import '../../../../home/ui/screens/home/data.dart';
import '../../../../home/ui/screens/home/widgets/product-section.dart';

class FavoriteScreen extends StatelessWidget {
  final bool empty;
  final Widget suffix;
  final Function() onSuffixTap;
  static const id = '/fav';

  const FavoriteScreen(
      {super.key,
      required this.empty,
      required this.suffix,
      required this.onSuffixTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              TitleRow(
                  onSuffixTap: () => deleteCollectionAlert(context),
                  onBackTap: () =>
                      Navigator.pushReplacementNamed(context, MenuScreen.id),
                  title: 'المفضلة',
                  suffix: InkWell(onTap: onSuffixTap, child: suffix)),
              SizedBox(
                height: 15.h,
              ),
              empty
                  ? Expanded(child: EmptyFav())
                  : SizedBox(
                      height: 270.h,
                      child: Padding(
                        padding: EdgeInsets.all(12.0.sp),
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index) =>
                                CustomGridView()),
                      )),
              ProductSection(
                  onMorePressed: () =>
                      Navigator.pushNamed(context, AdsScreen.id),
                  isHalfed: true,
                  category: "العروض والخصومات",
                  products: products),
              ProductSection(
                  onMorePressed: () =>
                      Navigator.pushNamed(context, AdsScreen.id),
                  isHalfed: true,
                  category: "الإعلانات الجديدة",
                  products: products),
              ProductSection(
                  onMorePressed: () =>
                      Navigator.pushNamed(context, AdsScreen.id),
                  isHalfed: true,
                  category: "الإعلانات المفترحة",
                  products: products),
            ],
          ),
        ),
      ),
    );
  }
}

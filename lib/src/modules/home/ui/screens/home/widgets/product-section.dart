import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/product-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../sections/models/ad.dart';
import 'custom-header.dart';

class ProductSection extends StatelessWidget {
  final String category;
  final List<AdModel> products;
  final Function() onMorePressed;
  final bool? hasDiscount;
  const ProductSection({
    super.key,
    required this.category,
    required this.products,
    required this.onMorePressed,
    this.hasDiscount = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomHeader(onPressed: onMorePressed, title: category),
      products.isNotEmpty
          ? Transform.translate(
              offset: Offset(0, -8.h),
              child: SizedBox(
                height: 120.h,
                child: ListView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  children: products
                      .map(
                        (product) => Padding(
                          padding: EdgeInsets.only(left: 16.0.w),
                          child: ProductItem(
                            hasDiscount: hasDiscount,
                            product: product,
                            category: category,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          : Center(
              child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h),
              child: Text(
                'لا يوجد اعلانات هنا',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ))
    ]);
  }
}

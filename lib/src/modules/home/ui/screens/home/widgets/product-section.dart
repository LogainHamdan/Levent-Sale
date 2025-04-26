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
  final double? height;
  final double? width;
  final bool? hasDiscount;
  const ProductSection({
    super.key,
    required this.category,
    required this.products,
    required this.onMorePressed,
    this.height = 169,
    this.width = 144,
    this.hasDiscount = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeader(onPressed: onMorePressed, title: category),
        Transform.translate(
          offset: Offset(0, -8.h),
          child: SizedBox(
            height: height,
            child: ListView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              children: products
                  .map(
                    (product) => Padding(
                      padding: EdgeInsets.only(left: 16.0.w),
                      child: ProductItem(
                        hasDiscount: hasDiscount,
                        height: height!,
                        width: width!,
                        product: product,
                        category: category,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

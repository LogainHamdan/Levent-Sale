import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/product-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom-header.dart';

class ProductSection extends StatelessWidget {
  final String category;
  final List<Map<String, String>> products;

  const ProductSection({
    super.key,
    required this.category,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeader(title: category),
        Transform.translate(
          offset: Offset(0, -8.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: products
                  .map(
                    (product) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: ProductItem(
                        product: product,
                        category: category,
                        isHalfed: false,
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

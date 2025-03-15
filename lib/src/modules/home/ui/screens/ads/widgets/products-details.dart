import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/data.dart';
import '../../home/widgets/product-item.dart';

class ProductsDetails extends StatelessWidget {
  const ProductsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductItem(
              isHalfed: true,
              product: products[index],
              category: '',
            );
          },
        ),
      ),
    );
  }
}

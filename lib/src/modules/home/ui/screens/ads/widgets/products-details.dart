import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../home/data.dart';
import '../../home/provider.dart';
import '../../home/widgets/product-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../home/data.dart';
import '../../home/provider.dart';
import '../../home/widgets/product-item.dart';

class ProductsDetails extends StatelessWidget {
  const ProductsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollProvider = context.read<HomeProvider>();

    scrollProvider.scrollToEnd();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.w,
        vertical: 16.0.h,
      ),
      child: SingleChildScrollView(
        reverse: true,
        controller: scrollProvider.scrollController,
        child: GridView.builder(
          shrinkWrap: true,
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
              hasDiscount: false,
              product: products.reversed.toList()[index],
              category: '',
            );
          },
        ),
      ),
    );
  }
}

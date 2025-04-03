import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/product-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom-header.dart';

class ProductSection extends StatelessWidget {
  final String category;
  final List<Map<String, String>> products;
  final bool? isHalfed;
  final Function() onMorePressed;
  final double? height;
  final double? width;
  const ProductSection({
    super.key,
    required this.category,
    required this.products,
    this.isHalfed = false,
    required this.onMorePressed,
    this.height = 169,
    this.width = 144,
  });

  @override
  Widget build(BuildContext context) {
    return !isHalfed!
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(onPressed: onMorePressed, title: category),
              Transform.translate(
                offset: Offset(0, -8.h),
                child: SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: products
                        .map(
                          (product) => ProductItem(
                            height: height!,
                            width: width!,
                            product: product,
                            category: category,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(onPressed: () {}, title: category),
              Transform.translate(
                offset: Offset(0, -8.h),
                child: SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: products
                        .map(
                          (product) => ProductItem(
                            height: height!,
                            width: width!,
                            product: product,
                            category: category,
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

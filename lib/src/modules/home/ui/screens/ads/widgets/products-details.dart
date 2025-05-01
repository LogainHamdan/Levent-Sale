import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../home/data.dart';
import '../../home/provider.dart';
import '../../home/widgets/product-item.dart';

class ProductsDetails extends StatelessWidget {
  final List<AdModel>? productList;

  const ProductsDetails({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    final scrollProvider = context.read<HomeProvider>();
    scrollProvider.scrollToEnd();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: productList != null && productList!.isNotEmpty
          ? SingleChildScrollView(
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
                itemCount: productList!.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    spacecUnderPic: true,
                    hasDiscount: false,
                    product: productList![index],
                    category: '',
                  );
                },
              ),
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Text(
                  'لا يوجد اعلانات هنا',
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
    );
  }
}

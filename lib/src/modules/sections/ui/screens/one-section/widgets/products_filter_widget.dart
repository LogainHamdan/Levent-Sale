import 'package:Levant_Sale/src/modules/sections/models/ad_model.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/widgets/product_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../home/ui/screens/home/provider.dart';




class ProductsFilterDetails extends StatelessWidget {
  final List<AdModel>? productList;

  const ProductsFilterDetails({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    final scrollProvider = context.read<HomeProvider>();

    scrollProvider.scrollToEnd();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
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
              childAspectRatio: 1.1,
            ),
            itemCount: productList!.length,
            itemBuilder: (context, index) {
              return ProductFilterItem(
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
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

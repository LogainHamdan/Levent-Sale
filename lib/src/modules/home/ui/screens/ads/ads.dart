import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tajawal/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:tajawal/src/modules/home/ui/screens/home/widgets/search-field.dart';
import 'package:tajawal/src/modules/home/ui/screens/home/widgets/top-search.dart';

import '../home/data.dart';
import '../home/home.dart';
import '../home/widgets/product-item.dart';

class AdsScreen extends StatelessWidget {
  static const id = '/id';

  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 35.h),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: TitleRow(title: 'الإعلانات')),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: SearchField(),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: GridView.builder(
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
                )),
          ),
        ],
      ),
    );
  }
}

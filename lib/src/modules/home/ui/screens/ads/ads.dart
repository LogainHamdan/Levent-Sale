import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/products-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/data.dart';
import '../home/home.dart';
import '../home/widgets/product-item.dart';
import '../home/widgets/search-field.dart';

class AdsScreen extends StatelessWidget {
  static const id = '/id';

  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 35.h),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: TitleRow(
                    onBackTap: () =>
                        Navigator.pushReplacementNamed(context, HomeScreen.id),
                    title: 'الإعلانات')),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: SearchField(),
            ),
            ProductsDetails()
          ],
        ),
      ),
    );
  }
}

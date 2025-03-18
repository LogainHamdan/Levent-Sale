import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';

import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/nav-bar/custom_nav_bar.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/empty-collection.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/join-collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../home/ui/screens/ads/widgets/products-details.dart';
import '../../../../home/ui/screens/home/data.dart';
import '../../../../home/ui/screens/home/widgets/product-section.dart';

class MyCollectionScreen extends StatelessWidget {
  final bool empty;
  static const id = '/collection';

  const MyCollectionScreen({super.key, required this.empty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          TitleRow(title: 'تشكيلتي'),
          empty
              ? Expanded(child: EmptyCollection())
              : Expanded(child: JoinMyCollection()),
          CustomBottomNavigationBar()
        ],
      ),
    );
  }
}

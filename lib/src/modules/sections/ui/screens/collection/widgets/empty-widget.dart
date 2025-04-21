import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/alerts/alert.dart';
import '../../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../../home/ui/screens/ads/ads.dart';
import '../../../../../home/ui/screens/home/data.dart';
import '../../../../../home/ui/screens/home/widgets/product-section.dart';

class EmptyWidget extends StatelessWidget {
  final String img;
  final String msg;

  final Widget child;

  const EmptyWidget(
      {super.key, required this.img, required this.child, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        SvgPicture.asset(
          img,
          height: 120.h,
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          msg,
          style: TextStyle(
            color: grey3,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        child,
        SizedBox(
          height: 10.h,
        ),
        SingleChildScrollView(
            child: Column(
          children: [
            ProductSection(
                onMorePressed: () => Navigator.pushNamed(context, AdsScreen.id),
                category: "العروض والخصومات",
                products: []),
            ProductSection(
                onMorePressed: () => Navigator.pushNamed(context, AdsScreen.id),
                category: "الإعلانات الجديدة",
                products: []),
            ProductSection(
                onMorePressed: () => Navigator.pushNamed(context, AdsScreen.id),
                category: "الإعلانات المفترحة",
                products: []),
          ],
        )),
      ],
    );
  }
}

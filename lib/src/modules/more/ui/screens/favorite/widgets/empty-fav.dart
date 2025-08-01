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

class EmptyFav extends StatelessWidget {
  const EmptyFav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        SvgPicture.asset(
          emptyFavIcon,
          height: 180.h,
          width: 180.w,
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          'المفضلة فارغة',
          style: TextStyle(
            color: grey3,
            fontSize: 20.sp,
          ),
        ),
      ],
    );
  }
}

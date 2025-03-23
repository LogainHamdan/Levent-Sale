import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/custom-rating.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/favorite-bitton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: grey7,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6.r,
            spreadRadius: 1.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  textDirection: TextDirection.rtl,
                  'ايفون 14 برو ماكس',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  textDirection: TextDirection.rtl,
                  'هاتف ذكي متطور ب.......',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: grey3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRating(rateNum: true, flexible: false),
                    Text(
                      '\$41.1',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: Image.asset(
                  'assets/imgs_icons/home/assets/imgs/ايفون1.png',
                  width: 130.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 5.w,
                top: 5.h,
                child: CustomButton(productKey: '', favIcon: true),
              )
            ],
          ),
        ],
      ),
    );
  }
}

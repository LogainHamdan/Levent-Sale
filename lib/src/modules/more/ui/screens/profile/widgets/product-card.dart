import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/custom-rating.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/favorite-bitton.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';

class ProductCard extends StatelessWidget {
  final AdModel ad;
  const ProductCard({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        provider.selectAd(ad);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdDetailsScreen(adId: ad.id)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                    ad.title ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    textDirection: TextDirection.rtl,
                    ad.description ?? '',
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
                      CustomRating(small: true, rateNum: true, flexible: false),
                      Text(
                        '${ad.currency} ${ad.price}',
                        style: TextStyle(
                          fontSize: 14.sp,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Image.network(
                      ad.imageUrls?.first ?? '',
                      width: 130.w,
                      height: 100.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 5.w,
                  top: 5.h,
                  child: CustomButton(
                    favIcon: true,
                    ad: ad,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

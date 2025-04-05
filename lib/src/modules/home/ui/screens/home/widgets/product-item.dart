import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../config/constants.dart';
import '../../ads/widgets/custom-rating.dart';
import 'dicount-badge.dart';
import 'favorite-bitton.dart';

class ProductItem extends StatelessWidget {
  final Map<String, String> product;
  final String category;
  final double? height;
  final double? width;
  final bool? hasDiscount;

  const ProductItem({
    super.key,
    required this.product,
    required this.category,
    this.height = 169,
    this.width = 144,
    this.hasDiscount = true,
  });

  @override
  Widget build(BuildContext context) {
    String productKey = '$category-${product['name']!}';

    return InkWell(
        onTap: () => Navigator.pushNamed(context, AdDetailsScreen.id),
        child: Container(
          height: height!.h,
          width: width!.w,
          decoration: BoxDecoration(
            color: grey7,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 84.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5.r),
                    topLeft: Radius.circular(5.r),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        product['image']!,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 8.h,
                        left: 8.w,
                        child:
                            CustomButton(favIcon: true, productKey: productKey),
                      ),
                      hasDiscount!
                          ? Positioned(
                              top: 12.h, right: 0.w, child: DiscountBadge())
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 4.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 12.h),
                      Text(
                        product['name']!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.sp),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        textDirection: TextDirection.rtl,
                        'هاتف ذكي متطور ب....',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomRating(flexible: false, rateNum: true),
                            Expanded(
                              child: Text(
                                product['price']!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

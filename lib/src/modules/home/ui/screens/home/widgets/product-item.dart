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
  final bool? spacecUnderPic;

  const ProductItem({
    super.key,
    required this.product,
    required this.category,
    this.height = 140,
    this.width = 144,
    this.hasDiscount = true,
    this.spacecUnderPic = false,
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
                height: 90.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5.r),
                    topLeft: Radius.circular(5.r),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        height: 125.h,
                        width: double.infinity,
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
                              top: 10.h, right: 0.w, child: DiscountBadge())
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
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
                      spacecUnderPic!
                          ? SizedBox(
                              height: 8.h,
                            )
                          : SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0.w),
                            child: CustomRating(
                              flexible: false,
                              rateNum: true,
                              small: true,
                            ),
                          ),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

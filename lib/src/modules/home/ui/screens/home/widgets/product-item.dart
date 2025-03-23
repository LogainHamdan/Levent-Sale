import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../config/constants.dart';
import '../../ads/widgets/custom-rating.dart';
import 'dicount-badge.dart';
import 'favorite-bitton.dart';

class ProductItem extends StatelessWidget {
  final Map<String, String> product;
  final String category;
  final bool isHalfed;
  const ProductItem({
    super.key,
    required this.product,
    required this.category,
    this.isHalfed = false,
  });

  @override
  Widget build(BuildContext context) {
    String productKey = '$category-${product['name']!}';

    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, AdDetailsScreen.id),
      child: Container(
          margin: EdgeInsets.all(8.sp),
          child: isHalfed
              ? Container(
                  height: 180.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: grey7,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5.r),
                            topLeft: Radius.circular(5.r),
                          ),
                          child: Stack(
                            children: [
                              Image.asset(
                                product['image']!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 5,
                                left: 5,
                                child: CustomButton(
                                    favIcon: true, productKey: productKey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product['name']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(
                              textDirection: TextDirection.rtl,
                              'هاتف ذكي متطور ب....',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                            CustomRating(flexible: false, rateNum: true),
                            Text(
                              product['price']!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  width: 150.w,
                  height: 180.h,
                  margin: EdgeInsets.only(right: 6.w, left: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: SizedBox(
                              width: double.infinity,
                              height: 80.h,
                              child: Image.asset(
                                product['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8.h,
                            left: 110.w,
                            child: DiscountBadge(),
                          ),
                          Positioned(
                            top: 6.h,
                            left: 6.w,
                            child: CustomButton(
                                favIcon: true, productKey: productKey),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        product['name']!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        product['description']!,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      CustomRating(flexible: false, rateNum: true),
                      SizedBox(
                        width: double.infinity,
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
                  ))),
    );
  }
}

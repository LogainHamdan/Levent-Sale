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

    return Container(
        margin: EdgeInsets.all(8),
        child: isHalfed
            ? Container(
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
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product['name']!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              textDirection: TextDirection.rtl,
                              'هاتف ذكي متطور ب....',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '4.4',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5),
                                CustomRating(rateNum: true)
                              ],
                            ),
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
                    ),
                  ],
                ),
              )
            : Container(
                width: 150.w,
                height: 175.h,
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            product['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                            top: 10.h, left: 100.h, child: DiscountBadge()),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: CustomButton(
                              favIcon: true, productKey: productKey),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      product['name']!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      product['description']!,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '4.4',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 5),
                        CustomRating(rateNum: true)
                      ],
                    ),
                    Text(
                      product['price']!,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ));
  }
}

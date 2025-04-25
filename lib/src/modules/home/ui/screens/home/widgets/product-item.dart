import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../config/constants.dart';
import '../../ads/widgets/custom-rating.dart';
import 'dicount-badge.dart';
import 'favorite-bitton.dart';

class ProductItem extends StatelessWidget {
  final AdModel product;
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
    final imageUrl =
        (product.imageUrls != null && product.imageUrls!.isNotEmpty)
            ? product.imageUrls!.first
            : '';

    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, AdDetailsScreen.id, arguments: product),
      child: Container(
        height: height!.h,
        width: width!.w,
        decoration: BoxDecoration(
          color: grey7,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: CustomButton(
                        favIcon: true,
                        ad: product,
                      ),
                    ),
                    if (hasDiscount ?? false)
                      Positioned(
                        top: 10.h,
                        right: 0.w,
                        child: const DiscountBadge(),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(right: 8.0.w, left: 8.0.w, top: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product.title ?? "بدون عنوان",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.sp),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      product.description ?? '',
                      textDirection: TextDirection.rtl,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomRating(
                          flexible: false,
                          rateNum: true,
                          small: true,
                        ),
                        Text(
                          "${product.price?.toStringAsFixed(0) ?? '0'} ${product.currency ?? ''}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    if (spacecUnderPic ?? false) SizedBox(height: 6.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

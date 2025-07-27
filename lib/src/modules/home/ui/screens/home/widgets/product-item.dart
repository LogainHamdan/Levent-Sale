import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../../ads/widgets/custom-rating.dart';
import 'dicount-badge.dart';
import 'favorite-bitton.dart';

class ProductItem extends StatelessWidget {
  final AdModel product;
  final String category;
  final double? width;
  final bool? hasDiscount;
  final bool? spacecUnderPic;

  const ProductItem({
    super.key,
    required this.product,
    required this.category,
    this.width = 150,
    this.hasDiscount = true,
    this.spacecUnderPic = false,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
    (product.imageUrls != null && product.imageUrls!.isNotEmpty)
        ? product.imageUrls!.first
        : '';
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        provider.selectAd(product);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdDetailsScreen(adId: product.id ?? 0)));
      },
      child: Container(
        width: width!.w,
        decoration: BoxDecoration(
          color: grey7,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        imageUrl ?? '',
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
                    // if (hasDiscount ?? false)
                    //   Positioned(
                    //     top: 10.h,
                    //     right: 0.w,
                    //     child: const DiscountBadge(),
                    //   ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product.title ?? "بدون عنوان",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.sp,
                      ),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      product.cleanDescription ?? '',
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "${product.price?.toStringAsFixed(0) ?? '0'} ${product.currency ?? ''}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(height: 4.h),
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
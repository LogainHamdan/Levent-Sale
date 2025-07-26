import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../provider.dart';
import 'favorite-bitton.dart';
class ProductItemVertical extends StatelessWidget {
  final AdModel product;
  final String category;
  final double? width;
  final double? height;
  final bool? hasDiscount;
  final bool? spacecUnderPic;
  final bool isHorizontal;
  final double? imageWidth;

  const ProductItemVertical({
    super.key,
    required this.product,
    required this.category,
    this.width,
    this.height,
    this.hasDiscount = true,
    this.spacecUnderPic = false,
    this.isHorizontal = true,
    this.imageWidth,
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
            builder: (context) => AdDetailsScreen(adId: product.id ?? 0),
          ),
        );
      },
      child: Container(
        width: isHorizontal ? null : (width ?? 150).w,
        height: isHorizontal ? (height ?? 120).h : null,
        decoration: BoxDecoration(
          color: grey7,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: isHorizontal
            ? _buildHorizontalLayout(imageUrl, context)
            : _buildVerticalLayout(imageUrl, context),
      ),
    );
  }

  Widget _buildHorizontalLayout(String imageUrl, BuildContext context) {
    return Row(
      children: [
        Container(
          width: (imageWidth ?? 100).w,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(8.r)),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
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
              ],
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product.title ?? "بدون عنوان",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      product.cleanDescription ?? '',
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "${product.price?.toStringAsFixed(0) ?? '0'} ${product.currency ?? ''}",
                    style: TextStyle(
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildVerticalLayout(String imageUrl, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
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
    );
  }
}

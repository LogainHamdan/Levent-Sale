import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../home/data.dart';
import '../../home/widgets/favorite-bitton.dart';
import '../provider.dart';

class CustomCarousel extends StatelessWidget {
  final String productKey = "iphone_14_pro_max";

  final List<String> imgList;

  CustomCarousel({super.key, required this.imgList});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdDetailsProvider(),
      child: Consumer<AdDetailsProvider>(
        builder: (context, carouselProvider, child) {
          return Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0.h,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        carouselProvider.updateIndex(index);
                      },
                    ),
                    items: imgList.map((item) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust border radius here
                        child: Image.asset(
                          item,
                          fit: BoxFit
                              .cover, // Ensure image covers the area with borders
                          width: double
                              .infinity, // Ensures the image stretches across the full width
                          height: 200.0
                              .h, // Matches the height of the CarouselSlider
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(Icons.broken_image,
                                  size: 50, color: Colors.grey),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  Positioned(
                    bottom: 10.h,
                    right: 10.w,
                    child: Container(
                      width: 70.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: grey5.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 10.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: Text(
                              "${carouselProvider.currentIndex + 1}/${imgList.length}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 10.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomButton(favIcon: true, productKey: productKey),
                        SizedBox(
                          width: 5.w,
                        ),
                        CustomButton(favIcon: false, productKey: productKey),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

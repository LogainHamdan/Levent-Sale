import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../provider.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, bannerProvider, child) {
        return CarouselSlider(
          options: CarouselOptions(
            height: 170.h,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              bannerProvider.updateIndex(index);
            },
          ),
          items: List.generate(2, (index) => bannerContent(context, index)),
        );
      },
    );
  }

  Widget bannerContent(BuildContext context, int index) {
    final bannerProvider = Provider.of<HomeProvider>(context);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            color: kprimaryColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          height: 140.h,
          width: 327.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/imgs_icons/home/assets/imgs/iphone12.png',
                  fit: BoxFit.contain,
                  height: 100.h,
                  width: 98.w,
                ),
                SvgPicture.asset(
                  rightOfBannerPath,
                  fit: BoxFit.contain,
                  height: 114.h,
                  width: 77.w,
                ),
              ],
            ),
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Positioned(
            bottom: 14.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                return Container(
                  width: 6.w,
                  height: 6.w,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bannerProvider.currentIndex == i ? grey9 : grey6,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';

import '../../../../../sections/ui/screens/reports/add-report.dart';

import '../../home/widgets/favorite-bitton.dart';
import '../provider.dart';

class CustomCarousel extends StatelessWidget {
  final String productKey = "iphone_14_pro_max";
  final AdModel? ad;

  const CustomCarousel({super.key, this.ad});

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
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      height: 200.0.h,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        carouselProvider.updateIndex(index);
                      },
                    ),
                    items: ad?.imageUrls?.map((item) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4.0.r),
                        child: Image.network(
                          item ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200.0.h,
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
                      width: 90.w,
                      height: 39.h,
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: BoxDecoration(
                        color: greyBlur,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              arrowBackCarousel,
                              height: 16.h,
                            ),
                            Text(
                              "${carouselProvider.currentIndex + 1}/${ad?.imageUrls?.length}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SvgPicture.asset(
                              arrowForwardCarousel,
                              height: 16.h,
                            ),
                          ],
                        ),
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
                        CircleAvatar(
                          radius: 14.w,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                final user = await UserHelper.getUser();
                                user != null
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportScreen(
                                                    adReport: true)))
                                    : loginFirstAlert(context);
                              },
                              child: Icon(
                                size: 20.sp,
                                CupertinoIcons.info,
                                color: kprimaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        CustomButton(
                          favIcon: false,
                          ad: ad,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        CustomButton(
                          favIcon: true,
                          ad: ad,
                        ),
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

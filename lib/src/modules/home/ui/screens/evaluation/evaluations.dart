import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/widgets/custom-like-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/widgets/member-info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import '../../../../../config/constants.dart';
import '../ads/widgets/custom-rating.dart';
import 'widgets/review-write.dart';
import '../ads/widgets/title-row.dart';
import '../home/home.dart';
import 'data.dart';

class ReviewsScreen extends StatelessWidget {
  static const id = '/review';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              TitleRow(
                  onBackTap: () => Navigator.pushNamed(context, AdsScreen.id),
                  title: 'التقييمات'),
              ReviewWrite(),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '(20 تقييم)',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomRating(
                        flexible: false,
                        rateNum: true,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];

                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: grey8,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 5.r,
                              spreadRadius: 2.r),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MemberInfo(
                            name: review['name'],
                            date: review['date'],
                            memberSince: review['memberSince'],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomRating(
                                flexible: false,
                                rateNum: false,
                              )
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.only(right: 8.0.w),
                            child: Text(
                              review['reviewText'],
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          if (review['images'].isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Row(
                                textDirection: TextDirection.rtl,
                                children: review['images'].map<Widget>((image) {
                                  return Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: SvgPicture.asset(
                                          image,
                                          width: 100.w,
                                          height: 80.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ));
                                }).toList(),
                              ),
                            ),
                          SizedBox(height: 8.h),
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              CustomLikeButton(
                                  type: LikeType.like, review: review),
                              SizedBox(width: 16.w),
                              CustomLikeButton(
                                  review: review, type: LikeType.dislike)
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

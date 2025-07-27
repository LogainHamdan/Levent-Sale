import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/widgets/custom-like-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/widgets/member-info.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/widgets/review-write.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/repos/token-helper.dart';
import '../../../models/rating.dart';
import '../ads/widgets/custom-rating.dart';
import '../ads/widgets/title-row.dart';
import 'data.dart';

class MyReviewsScreen extends StatefulWidget {
  static const id = '/my-review';

  const MyReviewsScreen({super.key});

  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  late Future<List<Rating>?> _futureReviews;
  @override
  void initState() {
    super.initState();
    _futureReviews = _loadReviews();
  }

  Future<List<Rating>?> _loadReviews() async {
    final provider = Provider.of<EvaluationProvider>(context, listen: false);

    final token = await TokenHelper.getToken();
    return provider.getMyRatings(token: token ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        title: const TitleRow(title: 'تقييماتي'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Rating>?>(
          future: _futureReviews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomCircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('حدث خطأ أثناء تحميل التقييمات'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('لا توجد تقييمات حتى الآن'));
            }

            final reviews = snapshot.data!;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '(${reviews.length} تقييم)',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // const CustomRating(
                          //   adId: ,
                          //   flexible: false,
                          //   rateNum: true,
                          // ),
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
                        final homeProvider =
                            Provider.of<HomeProvider>(context, listen: false);

                        return FutureBuilder(
                          future: homeProvider.getAdById(review.adId ?? 0),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CustomCircularProgressIndicator();
                            }
                            final ad = snapshot.data;
                            return GestureDetector(
                              onTap: () {
                                homeProvider.selectAd(ad ?? AdModel());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdDetailsScreen(
                                              adId: ad?.id ?? 0,
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  color: grey8,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 5.r,
                                      spreadRadius: 2.r,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomRating(
                                          adId: review.adId ?? 0,
                                          flexible: false,
                                          rateNum: false,
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            ad?.imageUrls?.first ?? '',
                                            width: 80.w, // Adjust size
                                            height: 50.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0.w),
                                      child: Text(
                                        review.comment ?? '',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        CustomLikeButton(
                                          type: LikeType.like,
                                          review: review,
                                        ),
                                        SizedBox(width: 16.w),
                                        CustomLikeButton(
                                          review: review,
                                          type: LikeType.dislike,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

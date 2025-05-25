import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/home/models/rating.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/widgets/custom-like-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/widgets/member-info.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import '../../../../../config/constants.dart';
import '../../../../auth/models/user.dart';
import '../ads/widgets/custom-rating.dart';
import 'widgets/review-write.dart';
import '../ads/widgets/title-row.dart';
import '../home/home.dart';
import 'data.dart';

class ReviewsScreen extends StatelessWidget {
  final int adId;
  static const id = '/review';

  const ReviewsScreen({super.key, required this.adId});

  Future<List<Rating>?> _loadReviewData(BuildContext context) async {
    final provider = Provider.of<EvaluationProvider>(context, listen: false);
    final token = await TokenHelper.getToken();
    return provider.getAdRatings(adId: adId, token: token ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        title: TitleRow(title: 'التقييمات'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: FutureBuilder(
              future: _loadReviewData(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CustomCircularProgressIndicator();
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: Text(
                      'لا تقييمات لهذا الإعلان بعد',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  );
                }
                final reviews = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReviewWrite(
                      adId: adId,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Text(
                            //   '(20 تقييم)',
                            //   textDirection: TextDirection.rtl,
                            //   style: TextStyle(
                            //     fontSize: 16.sp,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            CustomRating(
                              adId: adId,
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
                        itemCount: reviews?.length,
                        itemBuilder: (context, index) {
                          final review = reviews?[index];

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
                            child: FutureBuilder(
                              future: userProvider.getUserById(
                                  id: review?.userId ?? 0),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CustomCircularProgressIndicator();
                                }
                                final user = snapshot.data;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MemberInfo(
                                      date: review?.createdAt != null
                                          ? DateFormat('yyyy-MM-dd')
                                              .format(review!.createdAt!)
                                          : '',
                                      user: user ?? User(),
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomRating(
                                          adId: review?.adId??0,
                                          flexible: false,
                                          rateNum: false,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0.w),
                                      child: Text(
                                        review?.comment ?? '',
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ),
                                    if ([].isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.h),
                                        child: Row(
                                          children: [].map<Widget>((image) {
                                            return Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.w),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
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
                                      children: [
                                        CustomLikeButton(
                                            type: LikeType.like,
                                            review: review ?? Rating()),
                                        SizedBox(width: 16.w),
                                        CustomLikeButton(
                                            review: review ?? Rating(),
                                            type: LikeType.dislike)
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

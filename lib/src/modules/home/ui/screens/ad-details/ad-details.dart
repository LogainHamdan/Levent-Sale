import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/cutom-druggable-scrollable-sheet.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/product-item.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/choose-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../config/constants.dart';
import '../../../../auth/models/user.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../sections/models/ad.dart';
import '../../../../sections/ui/screens/choose-section/widgets/categories-display.dart';
import '../../../../sections/ui/screens/update-ad/update-ad.dart';
import '../ads/widgets/custom-rating.dart';
import '../ads/widgets/title-row.dart';
import '../evaluation/evaluations.dart';
import '../home/data.dart';
import '../home/provider.dart';
import '../home/widgets/custom-header.dart';
import '../home/widgets/product-section.dart';
import 'widgets/custom-carousel.dart';
import 'widgets/details-section.dart';
import 'widgets/rating-section.dart';
import 'widgets/simple-title.dart';
import 'widgets/specifications.dart';

class AdDetailsScreen extends StatelessWidget {
  final int adId;
  static const id = '/ad-details';

  const AdDetailsScreen({super.key, required this.adId});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final adProvider = Provider.of<AdDetailsProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await TokenHelper.getToken();
      await homeProvider.loadAds(token: token);
      await homeProvider.getAdById(adId);
    });

    return FutureBuilder(
        future: Future.wait([
          UserHelper.getUser(),
          homeProvider.getAdById(adId),
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: kprimaryColor),
              ),
            );
          }

          final user = snapshot.data![0] as User;
          final ad = homeProvider.selectedAd;
          print('userId before pass: ${ad?.userId}');

          return Scaffold(
            appBar: AppBar(
              leading: Row(
                children: [
                  if (user.id == ad?.userId)
                    Padding(
                      padding: EdgeInsets.only(left: 24.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateAdScreen(
                                          adId: adId,
                                          lowerWidget: SectionChoose(
                                            adId: adId,
                                          ),
                                        ))),
                            child: SvgPicture.asset(
                              editBlackIcon,
                              height: 20.h,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () async {
                              final token = await TokenHelper.getToken();
                              await adProvider.deleteAd(
                                  token: token ?? "", id: ad?.id ?? 0);
                            },
                            child: SvgPicture.asset(
                              deleteCollectionIcon,
                              height: 20.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              backgroundColor: Colors.white,
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              title: TitleRow(
                title: ad?.title ?? '',
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (ad != null)
                                      CustomCarousel(
                                        ad: ad,
                                      ),
                                    SizedBox(height: 24.0.h),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${ad?.price} ${ad?.currency}",
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            'نشر في ${ad?.createdAt ?? ''}',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: grey3,
                                            ),
                                          ),
                                          CustomRating(
                                            rateNum: true,
                                            flexible: false,
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            textDirection: TextDirection.rtl,
                                            ad?.description ?? '',
                                            maxLines: 4,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: grey2,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                    SimpleTitle(title: 'التعريفات'),
                                    SizedBox(height: 16.h),
                                    if (ad != null) DetailsSection(ad: ad),
                                    SizedBox(height: 24.h),
                                    SimpleTitle(title: 'الوصف'),
                                    SizedBox(height: 10.h),
                                    SpecificationsSection(
                                      title: 'تفاصيل',
                                      specifications: [
                                        '${ad?.longDescription}'
                                        // ' الأداء: أداء سريع وسلس مع تطبيقات متعددة.'
                                        //     ' التصوير: تحسينات كبيرة فى جودة الصورة والفيديو.'
                                        //     '  التوافق:  لتجربة إنترنت أسرع يدعم 65.'
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    SpecificationsSection(
                                        title: 'الفوائد',
                                        specifications: [
                                          '${ad?.longDescription}'
                                          // ' الأداء: أداء سريع وسلس مع تطبيقات متعددة.'
                                          //     ' التصوير: تحسينات كبيرة فى جودة الصورة والفيديو.'
                                          //     '  التوافق:  لتجربة إنترنت أسرع يدعم 65.'
                                        ]),
                                    SizedBox(height: 10.h),
                                    SpecificationsSection(
                                        title: 'التسليم والمرتجعات',
                                        specifications: [
                                          '${ad?.longDescription}'
                                          // ' الأداء: أداء سريع وسلس مع تطبيقات متعددة.'
                                          //     ' التصوير: تحسينات كبيرة فى جودة الصورة والفيديو.'
                                          //     '  التوافق:  لتجربة إنترنت أسرع يدعم 65.'
                                        ]),
                                    SizedBox(
                                      height: 24.h,
                                    )
                                  ],
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Column(
                                  children: [
                                    SimpleTitle(
                                      location: true,
                                      title: 'الموقع',
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    // CustomHeader(
                                    //   onPressed: () => Navigator.pushNamed(
                                    //       context, ReviewsScreen.id),
                                    //   title: 'متوسط التقييم',
                                    // ),
                                    // RatingSection(),
                                  ],
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: ProductSection(
                                    onMorePressed: () => Navigator.pushNamed(
                                        context, AdsScreen.id),
                                    category: 'مزيد من الإعلانات',
                                    products: homeProvider.allAds),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(height: 145.h),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomDraggableScrollableSheet(
                    adId: ad?.id ?? 0,
                    userId: ad?.userId ?? 0,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

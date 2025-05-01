import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/cutom-druggable-scrollable-sheet.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/product-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../config/constants.dart';
import '../../../../auth/models/user.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../sections/models/ad.dart';
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
  final AdModel ad;
  final bool? toUpdate;
  static const id = '/ad-details';

  const AdDetailsScreen({super.key, this.toUpdate = false, required this.ad});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await homeProvider.loadAds();
    });

    return FutureBuilder(
        future: UserHelper.getUser(),
        builder: (context, snapshot) {
          print(ad.userId);
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                color: kprimaryColor,
              )),
            );
          }
          final user = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 40.w,
              leading: Row(
                children: [
                  if (user.id == ad.userId)
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, UpdateAdScreen.id);
                      },
                      child: SvgPicture.asset(
                        editBlackIcon,
                        height: 20.h,
                      ),
                    ),
                ],
              ),
              backgroundColor: Colors.white,
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              title: TitleRow(
                title: ad.title ?? '',
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
                                    CustomCarousel(
                                      imgList: ad.imageUrls ?? [],
                                      ad: ad,
                                    ),
                                    SizedBox(height: 24.0.h),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${ad.price} ${ad.currency}",
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              'نشر في ${ad.createdAt ?? ''}',
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
                                              ad.description ?? '',
                                              maxLines: 4,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: grey2,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                    SimpleTitle(title: 'التعريفات'),
                                    SizedBox(height: 16.h),
                                    DetailsSection(ad: ad),
                                    SizedBox(height: 24.h),
                                    SimpleTitle(title: 'الوصف'),
                                    SizedBox(height: 10.h),
                                    SpecificationsSection(
                                      title: 'تفاصيل',
                                      specifications: [
                                        'شاشة Super Retina XDR بحجم 6.1 بوصة.',
                                        'نظام كاميرا مزدوجة 12 ميجابكسل.',
                                        'أداء عالي مع معالج A15 Bionic.',
                                        'دعم الشحن السريع والشحن اللاسلكي.',
                                        'مقاومة الماء والغبار بمعيار (IP68).',
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    SpecificationsSection(
                                        title: 'الفوائد',
                                        specifications: [
                                          ' الأداء: أداء سريع وسلس مع تطبيقات متعددة.'
                                              ' التصوير: تحسينات كبيرة فى جودة الصورة والفيديو.'
                                              '  التوافق:  لتجربة إنترنت أسرع يدعم 65.'
                                        ]),
                                    SizedBox(height: 10.h),
                                    SpecificationsSection(
                                        title: 'التسليم والمرتجعات',
                                        specifications: [
                                          ' توصيل مجاني: عند طلب الهاتف من المتاجر المعتمدة.'
                                              ' التسليم: عادةً ما يكون في غضون أيام عمل.'
                                              '  سياسة المرتجعات:  تحقق من الشروط الخاصة بهم.'
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
                    userId: ad.userId ?? user.id ?? 0,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/cutom-druggable-scrollable-sheet.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/product-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../sections/ui/screens/update-ad/update-ad.dart';
import '../ads/widgets/custom-rating.dart';
import '../ads/widgets/title-row.dart';
import '../evaluation/evaluations.dart';
import '../home/data.dart';
import '../home/widgets/custom-header.dart';
import '../home/widgets/product-section.dart';
import 'widgets/custom-carousel.dart';
import 'widgets/details-section.dart';
import 'widgets/rating-section.dart';
import 'widgets/simple-title.dart';
import 'widgets/specifications.dart';

class AdDetailsScreen extends StatelessWidget {
  final bool? toUpdate;
  static const id = '/ad-details';

  const AdDetailsScreen({super.key, this.toUpdate = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toUpdate!
          ? AppBar(
              leadingWidth: 40.w,
              leading: Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        deleteCollectionIcon,
                        height: 20.h,
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
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
              ),
              backgroundColor: Colors.white,
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              title: TitleRow(
                title: 'تعديل اعلان',
              ),
            )
          : AppBar(
              leading: SizedBox(),
              backgroundColor: Colors.white,
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              title: TitleRow(title: 'ايفون 14 برو ماكس'),
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
                              //  CustomCarousel(imgList: []),
                              SizedBox(height: 24.0.h),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$1000.1',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        'نشر قبل أسبوع',
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
                                        'هاتف آيفون 14 برو ماكس هو هاتف ذكي متطور بشاشة 6.7 بوصة، وكاميرا ثلاثية احترافية تتيح تصويرا عالي الجودة. يتميز بتقنية Super Retina XD، مما يوفر ألوانا زاهية وتفاصيل دقيقة في جميع ظروف الإضاءة',
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
                              DetailsSection(),
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
                              width: 120.w,
                              height: 130.h,
                              onMorePressed: () =>
                                  Navigator.pushNamed(context, AdsScreen.id),
                              category: 'مزيد من الإعلانات',
                              products: []),
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
            CustomDraggableScrollableSheet(),
          ],
        ),
      ),
    );
  }
}

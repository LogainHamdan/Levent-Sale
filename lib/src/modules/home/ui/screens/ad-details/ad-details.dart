import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/cutom-druggable-scrollable-sheet.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../ads/widgets/custom-rating.dart';
import '../ads/widgets/title-row.dart';
import '../evaluation/evaluations.dart';
import '../home/data.dart';
import '../home/widgets/custom-header.dart';
import 'widgets/custom-carousel.dart';
import 'widgets/details-section.dart';
import 'widgets/rating-section.dart';
import 'widgets/simple-title.dart';
import 'widgets/specifications.dart';

class AdDetailsScreen extends StatelessWidget {
  static const id = '/ad-details';

  const AdDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(16.0.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleRow(
                                  onBackTap: () =>
                                      Navigator.pushReplacementNamed(
                                          context, AdsScreen.id),
                                  title: 'آيفون 14 برو ماكس'),
                              CustomCarousel(imgList: productImages),
                              SizedBox(height: 10.0.h),
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
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        'نشر قبل أسبوع',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'متوسط التقييم',
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 160.0.w),
                                        child: CustomRating(
                                          rateNum: true,
                                          flexible: false,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        'هاتف آيفون 14 برو ماكس هو هاتف ذكي متطور بشاشة 6.7 بوصة، وكاميرا ثلاثية احترافية تتيح تصويرا عالي الجودة. يتميز بتقنية Super Retina XD، مما يوفر ألوانا زاهية وتفاصيل دقيقة في جميع ظروف الإضاءة',
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: grey4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SimpleTitle(title: 'التعريفات'),
                              DetailsSection(),
                              SizedBox(height: 20.h),
                              SimpleTitle(title: 'الوصف:'),
                              SizedBox(height: 10.h),
                              SpecificationsSection(
                                title: 'تفاصيل:',
                                specifications: [
                                  'شاشة Super Retina XDR بحجم 6.1 بوصة.',
                                  'نظام كاميرا مزدوجة 12 ميجابكسل.',
                                  'أداء عالي مع معالج A15 Bionic.',
                                  'دعم الشحن السريع والشحن اللاسلكي.',
                                  'مقاومة الماء والغبار بمعيار (IP68).',
                                ],
                              ),
                              SimpleTitle(title: 'الفوائد:'),
                              SizedBox(height: 10.h),
                              SpecificationsSection(
                                  title: 'تفاصيل:',
                                  specifications: [
                                    'الفوائد',
                                    ' الأداء: أداء سريع وسلس مع تطبيقات متعددة.'
                                        ' التصوير: تحسينات كبيرة فى جودة الصورة والفيديو.'
                                        '  التوافق:  لتجربة إنترنت أسرع يدعم 65.'
                                  ]),
                              SimpleTitle(title: 'التسليم والمرتجعات:'),
                              SizedBox(height: 10.h),
                              SpecificationsSection(
                                  title: 'تفاصيل:',
                                  specifications: [
                                    'الفوائد',
                                    ' توصيل مجاني: عند طلب الهاتف من المتاجر المعتمدة.'
                                        ' التسليم: عادةً ما يكون في غضون أيام عمل.'
                                        '  سياسة المرتجعات:  تحقق من الشروط الخاصة بهم.'
                                  ]),
                              SizedBox(
                                height: 10.h,
                              )
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SimpleTitle(
                                      title: 'الموقع',
                                    )),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 5.w),
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            CustomHeader(
                              onPressed: () => Navigator.pushReplacementNamed(
                                  context, ReviewsScreen.id),
                              title: 'متوسط التقييم',
                            ),
                            RatingSection(),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: 180.h),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CustomDraggableScrollableSheet(),
          ],
        ),
      ),
    );
  }
}

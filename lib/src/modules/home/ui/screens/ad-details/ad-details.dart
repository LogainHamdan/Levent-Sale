import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/cutom-druggable-scrollable-sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../ads/widgets/custom-rating.dart';
import '../ads/widgets/title-row.dart';
import '../home/data.dart';
import '../home/widgets/custom-header.dart';
import '../home/widgets/favorite-bitton.dart';
import 'widgets/custom-carousel.dart';
import 'widgets/details-section.dart';
import 'widgets/rating-section.dart';
import 'widgets/simple-title.dart';
import 'widgets/specifications.dart';

class AdDetailsScreen extends StatelessWidget {
  static const id = '/ad-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleRow(title: 'آيفون 14 برو ماكس'),
                      CustomCarousel(imgList: productImages),
                      SizedBox(height: 10.0.h),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$1000.1  ',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                '  نشر قبل أسبوع',
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey),
                              ),
                              Text(
                                '  متوسط التقييم',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 180.0.w),
                                child: CustomRating(rateNum: true),
                              ),
                              Text(
                                  maxLines: 4,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: grey4,
                                  ),
                                  '  هاتف آيفون 14 برو ماكس هو هاتف ذكي متطور بشاشة 6.7 بوصة، وكاميرا ثلاثية   احترافية تتيح تصويرا عالي الجودة. يتميز بتقنية Super Retina XD، مما يوفر ألوانا   زاهية وتفاصيل دقيقة في جميع ظروف الإضاءة'),
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
                      SizedBox(height: 10.h),
                      Center(
                        child: CustomElevatedButton(
                          notText: false,
                          text: 'متابعة',
                          onPressed: () {},
                          backgroundColor: kprimaryColor,
                          textColor: Colors.white,
                          date: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5.w),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0.h),
                            child: SimpleTitle(title: 'الموقع'),
                          ),
                        ],
                      ),
                      CustomHeader(title: 'متوسط التقييم'),
                      RatingSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          CustomDraggableScrollableSheet(),
        ],
      ),
    );
  }
}

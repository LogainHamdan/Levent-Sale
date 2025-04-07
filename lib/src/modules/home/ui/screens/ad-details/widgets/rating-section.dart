import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/rating-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/custom-rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0.h,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RatingRow(stars: 4, count: 600, value: 1.0),
                  SizedBox(height: 8.h),
                  RatingRow(stars: 3, count: 100, value: 0.5),
                  SizedBox(height: 8.h),
                  RatingRow(stars: 2, count: 50, value: 0.1),
                  SizedBox(height: 8.h),
                  RatingRow(stars: 1, count: 50, value: 0.1),
                ],
              ),
              SizedBox(
                width: 32.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('4.4',
                        style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp),
                        )),
                    CustomRating(
                      rateNum: false,
                      flexible: false,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text('(900 تقييم)',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: grey2, fontSize: 14.sp)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

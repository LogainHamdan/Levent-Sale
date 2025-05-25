import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/rating-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/custom-rating.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../evaluation/provider.dart';

class RatingSection extends StatelessWidget {
  final int adId;
  const RatingSection({super.key, required this.adId});

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
                          adId:adId,
                          rateNum: false,
                          flexible: false,
                        ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text('(التقييمات)',
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

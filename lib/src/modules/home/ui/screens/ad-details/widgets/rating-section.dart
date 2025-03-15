import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/rating-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/custom-rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingRow(stars: 4, count: 600, value: 1.0),
                    SizedBox(height: 5),
                    RatingRow(stars: 3, count: 100, value: 0.5),
                    SizedBox(height: 5),
                    RatingRow(stars: 2, count: 50, value: 0.1),
                    SizedBox(height: 5),
                    RatingRow(stars: 1, count: 50, value: 0.1),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '4.4',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.sp),
                  ),
                  CustomRating(rateNum: false),
                  Text('(900 تقييم)', style: TextStyle(fontSize: 16.sp)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

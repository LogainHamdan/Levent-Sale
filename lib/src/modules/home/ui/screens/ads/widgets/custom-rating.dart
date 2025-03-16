import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';

class CustomRating extends StatelessWidget {
  final bool flexible;
  final bool rateNum;
  const CustomRating({
    super.key,
    required this.rateNum,
    required this.flexible,
  });

  @override
  Widget build(BuildContext context) {
    final ratingProvider = Provider.of<EvaluationProvider>(context);

    return !flexible
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              rateNum
                  ? Text(
                      '4.4',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  : SizedBox(),
              SizedBox(width: 2.w),
              Directionality(
                textDirection: TextDirection.rtl,
                child: StarRating(
                  rating: 4.4,
                  size: 16.sp,
                  color: amberColor,
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: StarRating(
                  rating: ratingProvider.rating,
                  size: 25.sp,
                  color: amberColor,
                  onRatingChanged: (newRating) {
                    ratingProvider.updateRating(newRating);
                  },
                ),
              ),
              SizedBox(width: 5.w),
              rateNum
                  ? Text(
                      ratingProvider.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : SizedBox(),
            ],
          );
  }
}

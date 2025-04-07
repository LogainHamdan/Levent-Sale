import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';

class CustomRating extends StatelessWidget {
  final bool flexible;
  final bool rateNum;
  final bool? small;
  const CustomRating({
    super.key,
    required this.rateNum,
    this.small = false,
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
                  ? Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        '4.4',
                        style: GoogleFonts.tajawal(
                            textStyle: TextStyle(
                                fontSize: small! ? 14.sp : 16.sp,
                                fontWeight: small!
                                    ? FontWeight.w400
                                    : FontWeight.bold)),
                      ),
                    )
                  : SizedBox(),
              SizedBox(width: 2.w),
              Directionality(
                textDirection: TextDirection.rtl,
                child: StarRating(
                  rating: 4.4,
                  size: small! ? 12.sp : 20.sp,
                  starCount: 4,
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
                  size: small! ? 10.sp : 20.sp,
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
                        fontSize: small! ? 10.sp : 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : SizedBox(),
            ],
          );
  }
}

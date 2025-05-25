import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/repos/token-helper.dart';
import '../../home/widgets/custom-indicator.dart';

class CustomRating extends StatefulWidget {
  final bool flexible;
  final bool rateNum;
  final bool? small;
  final int adId;
  const CustomRating({
    super.key,
    required this.rateNum,
    this.small = false,
    required this.flexible,
    required this.adId,
  });

  @override
  State<CustomRating> createState() => _CustomRatingState();
}

class _CustomRatingState extends State<CustomRating> {
  late EvaluationProvider provider;
  late Future<double?> _ratingFuture;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<EvaluationProvider>(context, listen: false);
    _ratingFuture = _loadData();
  }

  Future<double?> _loadData() async {
    final token = await TokenHelper.getToken();
    return provider.getAdAvg(token: token ?? '', adId: widget.adId);
  }

  @override
  Widget build(BuildContext context) {
    final ratingProvider = Provider.of<EvaluationProvider>(context);

    return !widget.flexible
        ? FutureBuilder<double?>(
            future: _ratingFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomCircularProgressIndicator();
              } else if (snapshot.data == null) {
                return Center(child: Text('لا تقييمات حتى الآن'));
              }
              final avg = snapshot.data;
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.rateNum)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '$avg',
                        style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                            fontSize: widget.small! ? 14.sp : 16.sp,
                            fontWeight: widget.small!
                                ? FontWeight.w400
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(width: 2.w),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: StarRating(
                      rating: avg ?? 0,
                      size: widget.small! ? 12.sp : 20.sp,
                      starCount: 4,
                      color: amberColor,
                    ),
                  ),
                ],
              );
            },
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: StarRating(
                  rating: ratingProvider.rating,
                  size: widget.small! ? 10.sp : 20.sp,
                  color: amberColor,
                  onRatingChanged: (newRating) {
                    ratingProvider.updateRating(newRating);
                  },
                ),
              ),
              SizedBox(width: 5.w),
              if (widget.rateNum)
                Text(
                  ratingProvider.rating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: widget.small! ? 10.sp : 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          );
  }
}

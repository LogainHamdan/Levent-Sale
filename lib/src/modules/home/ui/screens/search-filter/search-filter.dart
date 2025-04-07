import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search-filter/widgets/card.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search-filter/widgets/horizontal-navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../home/data.dart';
import '../home/widgets/search-field.dart';

class FilterScreen extends StatelessWidget {
  static const id = '/filter';
  final int cardListIndex;

  const FilterScreen({super.key, required this.cardListIndex});

  @override
  Widget build(BuildContext context) {
    TextEditingController filterController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Row(
                children: [
                  SearchField(
                    width: 270.w,
                    controller: filterController,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  InkWell(
                      child: Icon(
                        Icons.arrow_forward_outlined,
                        size: 24.sp,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      })
                ],
              ),
              SizedBox(
                height: 24.w,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    if (cardListIndex == 0) {
                      return CustomCard(
                        onTap: () => Navigator.push(
                          context,
                          createHorizontalPageRoute(
                            FilterScreen(cardListIndex: 1),
                          ),
                        ),
                        icon: SvgPicture.asset(height: 15.h, arrowLeftPath),
                        title: categories[index]['name'],
                      );
                    }
                    if (cardListIndex == 1) {
                      return CustomCard(
                        onTap: () => Navigator.push(
                          context,
                          createHorizontalPageRoute(
                            FilterScreen(cardListIndex: 2),
                          ),
                        ),
                        icon: SvgPicture.asset(height: 15.h, arrowLeftPath),
                        title: 'شقق فاخرة و مفروشة',
                      );
                    }
                    if (cardListIndex == 2) {
                      return CustomCard(
                        onTap: () => Navigator.pushNamed(context, AdsScreen.id),
                        icon: SvgPicture.asset(height: 15.h, arrowLeftPath),
                        title: 'شقق فاخرة و مفروشة',
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

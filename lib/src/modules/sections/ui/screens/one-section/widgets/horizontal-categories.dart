import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../choose-section/create-ad-choose-section-provider.dart';
import '../one-section.dart';

class HorizontalCategories extends StatelessWidget {
  const HorizontalCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CreateAdChooseSectionProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return SingleChildScrollView(
      reverse: true,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: provider.rootCategories.map((category) {
          return Row(
            children: [
              SizedBox(width: 10.w),
              Text(
                '${category.productCount}',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
              ),
              SizedBox(width: 2.w),
              Text(
                category.name,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeProvider.selectedCategory == category
                      ? kprimaryColor
                      : Colors.grey.shade200,
                ),
                child: GestureDetector(
                  onTap: () {
                    homeProvider.selectCategory(category);
                    Navigator.pushReplacementNamed(context, Section.id);
                  },
                  child: Center(
                    child: Image.network(category.imageUrl ?? '',
                        width: 25.w, height: 25.h),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

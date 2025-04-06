import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../../../../../home/ui/screens/home/data.dart';
import '../../one-section/one-section.dart';
import '../choose-section-provider.dart';

class CategoriesDisplay extends StatelessWidget {
  final Function() onSectionClicked;

  const CategoriesDisplay({super.key, required this.onSectionClicked});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChoosesSectionProvider>(context);
    final selectedIndex = provider.selectedCategoryIndex;

    return SizedBox(
      height: 800.h,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: categoryNames.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return InkWell(
            borderRadius: BorderRadius.circular(80.r),
            onTap: () {
              provider.setSelectedCategory(index);
              Future.delayed(const Duration(seconds: 1), () {
                onSectionClicked();
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? kprimaryColor : grey8,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0.sp),
                    child: ClipOval(
                      child: Image.asset(
                        categoryImages[index],
                        height: 30.h,
                        width: 30.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Flexible(
                  child: Text(
                    categoryNames[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
